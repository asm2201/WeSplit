//
//  ContentView.swift
//  WeSplit
//
//  Created by Anushka Mathur on 29/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    private let tipPercentages = [0, 10, 15, 20, 25]
    @State private var tip = 20
    @FocusState private var checkAmountIsFocussed: Bool
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tip)
        let tipValue = (tipSelection * checkAmount)/100
        let grandTotal = tipValue + checkAmount
        let amountPerPerson = grandTotal/peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Enter The Total Amount") {
                    TextField("Amount: ", value: $checkAmount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($checkAmountIsFocussed)
                }
                Section("How much tip do you want to leave?"){
                    Picker("Tip Percentage", selection: $tip){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section{
                    Picker("Number Of People: ", selection: $numberOfPeople) {
                        ForEach(2..<100, id: \.self) {
                            Text("\($0) People")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Amount Per Person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if checkAmountIsFocussed{
                    Button("Done"){
                        checkAmountIsFocussed = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
