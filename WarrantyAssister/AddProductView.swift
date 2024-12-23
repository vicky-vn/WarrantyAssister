//
//  ContentView.swift
//  WarrantyAssister
//
//  Created by Vignesh Natarajan on 26/07/24.
//

import SwiftUI

struct AddProductView: View {
    @EnvironmentObject var warrantyStorage: WarrantyStorage
    
    @State private var name = ""
    @State private var category = ""
    @State private var store = ""
    @State private var warrantyPeriod = ""
    @State private var returnPeriod = ""
    @State private var purchaseDate = Date()
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Form {
                    Section(header: Text("Add New Warranty")) {
                        TextField("Product Name", text: $name)
                        TextField("Category", text: $category)
                        TextField("Store Name", text: $store)
                        TextField("Warranty Period (days)", text: $warrantyPeriod)
                            .keyboardType(.numberPad)
                        TextField("Return Period (days)", text: $returnPeriod)
                            .keyboardType(.numberPad)
                        DatePicker("Purchase Date", selection: $purchaseDate, displayedComponents: .date)
                    }
                }
                .frame(minHeight: 400)
                
                Button(action: saveWarranty) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)
                }
                .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle("Add Product Info")
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Notification"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if alertMessage == "Product added successfully!" {
                        // Navigate back to previous view
                    }
                }
            )
        }
    }

    private func saveWarranty() {
        guard let warrantyPeriodInt = Int(warrantyPeriod), let returnPeriodInt = Int(returnPeriod) else {
            alertMessage = "Invalid input. Please enter numeric values for warranty and return periods."
            showingAlert = true
            return
        }
        
        let newWarranty = Warranty(name: name, category: category, store: store, warrantyPeriod: warrantyPeriodInt, returnPeriod: returnPeriodInt, purchaseDate: purchaseDate)
        
        warrantyStorage.add(warranty: newWarranty)
        
        name = ""
        category = ""
        store = ""
        warrantyPeriod = ""
        returnPeriod = ""
        purchaseDate = Date()
        
        alertMessage = "Product added successfully!"
        showingAlert = true
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
            .environmentObject(WarrantyStorage())
    }
}
