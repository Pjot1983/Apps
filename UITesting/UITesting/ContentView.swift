//
//  ContentView.swift
//  UITesting
//
//  Created by Pjot on 22.11.2022.
//

import SwiftUI

class UITestViewModel: ObservableObject {
    
    let placeHolderText: String = "Please, add your name"
    @Published var textFieldText: String = ""
    @Published var goIsPressed: Bool = false
    
    func goButtonIsPressed () {
        guard !textFieldText.isEmpty else { return }
        goIsPressed = true
    }
}

struct ContentView: View {
    
    @StateObject private var vm = UITestViewModel()
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ZStack {
                
                if vm.goIsPressed {
                    SignedHomeView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                }
                
                if !vm.goIsPressed {
                    goLayer
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }

            }
            
        }
    }
}

extension ContentView {
    
    private var goLayer: some View {
        
        VStack {
            TextField(vm.placeHolderText, text: $vm.textFieldText)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .accessibilityIdentifier("SignUpTextField")
            
            Button  {
                withAnimation(.spring(), {
                    vm.goButtonIsPressed()
                })
                
            } label: {
                Text("Go")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
                    .accessibilityIdentifier("SingUpButton")
            }
        } .padding()
        
    }

}

struct SignedHomeView: View {
    
    @State private var showAlert: Bool = false
    
    @StateObject private var vm = UITestViewModel()
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.black]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack (spacing: 20) {
                    
                    Button  {
                        showAlert.toggle()
                    } label: {
                            Text("Show welcome alert")
                                .font(.title3)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.black)
                                .background(RadialGradient(gradient: Gradient(colors: [Color.pink, Color.orange, Color.yellow, Color.green,Color.blue, Color.purple]), center: .center, startRadius: 5, endRadius: 180))
                                .cornerRadius(10)
                                .accessibility(identifier: "AlertButton")
                    
                    }
                    .padding()
                    .alert(isPresented: $showAlert) {
                        return Alert(title: Text("WELCOME!!!"))
                    }
                    
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            Text("Navigate")
                                .font(.title3)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.black)
                                .background(RadialGradient(gradient: Gradient(colors: [Color.pink, Color.orange, Color.yellow, Color.green,Color.blue, Color.purple]), center: .center, startRadius: 5, endRadius: 180))
                                .cornerRadius(10)
                        }).padding()
                        .navigationTitle("Welcome!!!")
                }
                
            }
                
            }
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
