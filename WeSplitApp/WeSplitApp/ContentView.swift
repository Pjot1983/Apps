//
//  ContentView.swift
//  WeSplitApp
//
//  Created by Pjot on 23.11.2022.
//

import SwiftUI

struct WeSplit: View {
    
    @State private var totalAmount: Double = 0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    
    let percentageValues = [0, 5, 10, 15, 20]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = totalAmount/100 * tipSelection
        
        let splitNumber = (totalAmount + tipValue)/peopleCount
        
        return splitNumber
    }

    var body: some View {
            
            NavigationView {
                
                Form {
                    Section {
                        TextField("Add total sum", value: $totalAmount, format:
                                .currency(code: Locale.current.currencyCode ?? "USD"))
                                .keyboardType(.decimalPad)
                        
                        Picker ("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<7) {
                                Text("\($0) people")
                            }
                        }
                    }
                  
                    Section {
                        
                        Picker("Add yout tip", selection: $tipPercentage) {
                            
                            ForEach(percentageValues, id: \.self) {
                                Text($0, format: .percent)
                            }

                        }.pickerStyle(.segmented)
                        
                    } header: {
                        Text("How much do you want to tip?")
                    }
                            
                    
                    Section {
                        Text("Total amount per capita is \(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                    }

                }
                .navigationBarTitle("Sharing is caring")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeSplit()
    }
}
