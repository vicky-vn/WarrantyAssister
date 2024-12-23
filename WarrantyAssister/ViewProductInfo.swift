//
//  ViewProductInfo.swift
//  WarrantyAssister
//
//  Created by Vignesh Natarajan on 26/07/24.
//

import SwiftUI

struct ViewProductInfo: View {
    @EnvironmentObject var warrantyStorage: WarrantyStorage
    @State private var selectedCategory: String = "All"
    @State private var selectedStore: String = "All"

    var categories: [String] {
        let allCategories = warrantyStorage.warranties.map { $0.category }
        return ["All"] + Set(allCategories).sorted()
    }
    
    var stores: [String] {
        let allStores = warrantyStorage.warranties.map { $0.store }
        return ["All"] + Set(allStores).sorted()
    }

    var filteredWarranties: [Warranty] {
        warrantyStorage.warranties.filter { warranty in
            (selectedCategory == "All" || warranty.category == selectedCategory) &&
            (selectedStore == "All" || warranty.store == selectedStore)
        }
    }

    var body: some View {
        VStack {
            HStack {
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                
                Picker("Store", selection: $selectedStore) {
                    ForEach(stores, id: \.self) { store in
                        Text(store).tag(store)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
            }

            List {
                ForEach(filteredWarranties) { warranty in
                    NavigationLink(destination: EditProductView(warranty: warranty)) {
                        VStack(alignment: .leading) {
                            Text(warranty.name).font(.headline)
                            Text("Return Period: \(daysRemaining(for: warranty.returnPeriod, from: warranty.purchaseDate)) days remaining")
                                .font(.subheadline)
                            Text("Warranty Period: \(daysRemaining(for: warranty.warrantyPeriod, from: warranty.purchaseDate)) days remaining")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("View Product Info")
        }
    }
    
    private func daysRemaining(for period: Int, from date: Date) -> Int {
        let endDate = Calendar.current.date(byAdding: .day, value: period, to: date)!
        let remainingDays = Calendar.current.dateComponents([.day], from: Date(), to: endDate).day ?? 0
        return max(remainingDays, 0)
    }
}

struct ViewProductInfo_Previews: PreviewProvider {
    static var previews: some View {
        ViewProductInfo()
            .environmentObject(WarrantyStorage())
    }
}
