//
//  GuessTheFlag.swift
//  100days
//
//  Created by Pjot on 08.11.2022.
//

import SwiftUI

struct GuessTheFlag: View {
    
    @State var actualScore = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack (spacing: 30){
                VStack (spacing: 10){
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3) {number in
                    Button{
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Next question", role:.cancel, action: askQuestion)
        } message: {
            Text("Your score is \(actualScore)")
        }
    }
    
    func askQuestion () {
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!!! :)"
            actualScore += 1
        } else {
            scoreTitle = "Wrong!!! :("
        }
        showingScore = true
    }
}


struct GuessTheFlag_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlag()
    }
}
