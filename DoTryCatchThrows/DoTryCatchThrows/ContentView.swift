//
//  ContentView.swift
//  DoTryCatchThrows
//
//  Created by Pjot on 24.10.2022.
//



import SwiftUI

class DoTryCatchThrowsDataManager {
    
    let isActive: Bool = true
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("New text", nil)
        } else {
            return (nil, URLError(.badURL))
        }
        
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("New text")
        } else {
            return .failure(URLError(.badURL))
        }
    }
    
    func getTitle3() throws -> String {
        if isActive {
            return "New text"
        } else {
            throw URLError(.badURL)
        }
    }
    
    func getTitle4 () throws -> String {
        if isActive {
            return "Final text"
        } else {
            throw URLError(.badURL)
        }
    }
    
}


class DoTryCatchThrows: ObservableObject {
    
    @Published var text: String = "Starting text."
    let manager = DoTryCatchThrowsDataManager()
    
    func fetchTitle () {
        /*
         let returnedValue = manager.getTitle()
         if let newTitle = returnedValue.title {
         self.text = newTitle
         } else if let error = returnedValue.error {
         self.text  = error.localizedDescription
         }*/
        
        /*
         
         let result = manager.getTitle2()
         
         switch result {
         case .success(let newTitle):
         self.text = newTitle
         
         case .failure(let error):
         self.text = error.localizedDescription */
        
        do {
            let newTitle = try? manager.getTitle3()
            if let newTitle = newTitle {
                self.text = newTitle
            }
   
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle
            
        } catch let error {
            self.text = error.localizedDescription
        }
        
    }
}



struct ContentView: View {
    
    @StateObject var vm = DoTryCatchThrows()
    
    var body: some View {
        
        Text(vm.text)
            .frame(width: 300, height: 300)
            .background(.blue)
            .padding()
            .onTapGesture {
                vm.fetchTitle()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
