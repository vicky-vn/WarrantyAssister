//
//  ProductDetailView.swift
//  WarrantyAssister
//
//  Created by Vignesh Natarajan on 26/07/24.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var warrantyStorage: WarrantyStorage
    var warranty: Warranty
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(warranty.name)")
                .font(.headline)
            Text("Category: \(warranty.category)")
                .font(.subheadline)
            Text("Store: \(warranty.store)")
                .font(.subheadline)
            Text("Warranty Period: \(warranty.warrantyPeriod) days")
                .font(.subheadline)
            Text("Return Period: \(warranty.returnPeriod) days")
                .font(.subheadline)
            Text("Purchase Date: \(formattedDate(warranty.purchaseDate))")
                .font(.subheadline)
            
            Button(action: {
                let returnRemaining = calculateRemainingDays(from: warranty.purchaseDate, period: warranty.returnPeriod)
                let warrantyRemaining = calculateRemainingDays(from: warranty.purchaseDate, period: warranty.warrantyPeriod)
                alertMessage = "\(returnRemaining) days remaining for return period\n\(warrantyRemaining) days remaining for warranty"
                showingAlert = true
            }) {
                Text("Show Reminder")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Reminder"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            NavigationLink(destination: EditProductView(warranty: warranty)) {
                Text("Edit Product Info")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(warranty.name)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    private func calculateRemainingDays(from date: Date, period: Int) -> Int {
        let endDate = Calendar.current.date(byAdding: .day, value: period, to: date)!
        let remainingDays = Calendar.current.dateComponents([.day], from: Date(), to: endDate).day ?? 0
        return remainingDays
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(warranty: Warranty(name: "Sample Product", category: "Sample Category", store: "Sample Store", warrantyPeriod: 365, returnPeriod: 30, purchaseDate: Date()))
            .environmentObject(WarrantyStorage())
    }
}
