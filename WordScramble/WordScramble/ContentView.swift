//
//  WordScramble.swift
//  100days
//
//  Created by Pjot on 09.11.2022.
//

import SwiftUI

struct WordScramble: View {
    
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var rootWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var scoreWords = 0
    @State private var scorePerWord = 0
    
    var body: some View {
        
        NavigationView {
            List {
                Section {
                    TextField("Add your word", text: $newWord)
                        .autocapitalization(.none)
                        .onSubmit {addWord()}
                    
                }
                Section {
                    
                    ForEach(usedWords, id: \.self) {word in
                        
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        
                    }
                }
                
                
                
                Section {
                    
                    Text("Your current score for number of words is \(scoreWords) \n, your score for number of used letters is \(scorePerWord) \n, total score is \(scoreWords + scorePerWord)")
                    
                }
                
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("New Game", action: {startGame()})
            }
        }
        
        .onAppear(perform: rootString)
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK", role: .cancel) {}
            
        } message: {
            Text(errorMessage)
        }
        
    }
    
    func addWord () {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 2 else { return wordError(title: "Not enough long", message: "At least 3 letters count")}
        
        guard answer != rootWord else { return wordError(title: "Do not repeat", message: "Same word is not valid")}
        
        guard isOriginal(word: answer) else { return wordError(title: "Word used already", message: "Try a new word")}
        
        guard isPossible(word: answer) else { return wordError(title: "Hmm...not possible..sorry", message: "You can use all letter only once..do you understande?")}
        
        guard isCorrect(word: answer) else { return wordError(title: "Not even English", message: "Go back to school and then try again") }
        
        
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
        
        scoreCounter(word: answer)
    }
    
    func rootString() {
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: fileURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "deadEND"
                return
            }
        }
        
        fatalError("Could not load start.txt")
    }
    
    func isOriginal (word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible (word: String) -> Bool {
        
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isCorrect (word: String) -> Bool {
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
        
    }
    
    func wordError (title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
        newWord = ""
    }
    
    func startGame () {
        usedWords = [String]()
        newWord = ""
        
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: fileURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "deadEND"
                return
            }
        }
    }
    
    func scoreCounter(word: String) {
        scoreWords = usedWords.count
        scorePerWord += word.count
        
        
    }
    
}
            

struct WorldScramble_Previews: PreviewProvider {
        
    static var previews: some View {
                    WordScramble()
        }
}


