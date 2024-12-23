//  EditProductView.swift
//  WarrantyAssister
//
//  Created by Vignesh Natarajan on 26/07/24.
//

import SwiftUI

struct EditProductView: View {
    @EnvironmentObject var warrantyStorage: WarrantyStorage
    var warranty: Warranty
    
    @State private var name: String
    @State private var category: String
    @State private var store: String
    @State private var warrantyPeriod: String
    @State private var returnPeriod: String
    @State private var purchaseDate: Date
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var showingDeleteAlert = false
    @State private var deleteAlertMessage = ""

    init(warranty: Warranty) {
        self.warranty = warranty
        _name = State(initialValue: warranty.name)
        _category = State(initialValue: warranty.category)
        _store = State(initialValue: warranty.store)
        _warrantyPeriod = State(initialValue: String(warranty.warrantyPeriod))
        _returnPeriod = State(initialValue: String(warranty.returnPeriod))
        _purchaseDate = State(initialValue: warranty.purchaseDate)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Form {
                    Section(header: Text("Edit Warranty")) {
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
                
                Button(action: saveChanges) {
                    Text("Save Changes")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)
                }
                .padding(.top, 10)
                
                Button(action: {
                    showingDeleteAlert = true
                }) {
                    Text("Delete Product")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)
                }
                .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle("Edit Product Info")
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Notification"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if alertMessage == "Product updated successfully!" {
                        // Navigate back to previous view
                    }
                }
            )
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("Delete Product"),
                message: Text("Are you sure you want to delete this product?"),
                primaryButton: .destructive(Text("Delete")) {
                    deleteProduct()
                },
                secondaryButton: .cancel()
            )
        }
    }

    private func saveChanges() {
        guard let warrantyPeriodInt = Int(warrantyPeriod), let returnPeriodInt = Int(returnPeriod) else {
            alertMessage = "Invalid input. Please enter numeric values for warranty and return periods."
            showingAlert = true
            return
        }
        
        if let index = warrantyStorage.warranties.firstIndex(where: { $0.id == warranty.id }) {
            warrantyStorage.warranties[index].name = name
            warrantyStorage.warranties[index].category = category
            warrantyStorage.warranties[index].store = store
            warrantyStorage.warranties[index].warrantyPeriod = warrantyPeriodInt
            warrantyStorage.warranties[index].returnPeriod = returnPeriodInt
            warrantyStorage.warranties[index].purchaseDate = purchaseDate
            
            alertMessage = "Product updated successfully!"
            showingAlert = true
        } else {
            alertMessage = "Product not found."
            showingAlert = true
        }
    }

    private func deleteProduct() {
        if let index = warrantyStorage.warranties.firstIndex(where: { $0.id == warranty.id }) {
            warrantyStorage.warranties.remove(at: index)
            
            alertMessage = "Product deleted successfully!"
            showingAlert = true
        } else {
            alertMessage = "Product not found."
            showingAlert = true
        }
    }
}

struct EditProductView_Previews: PreviewProvider {
    static var previews: some View {
        EditProductView(warranty: Warranty(name: "Sample Product", category: "Sample Category", store: "Sample Store", warrantyPeriod: 365, returnPeriod: 30, purchaseDate: Date()))
            .environmentObject(WarrantyStorage())
    }
}
