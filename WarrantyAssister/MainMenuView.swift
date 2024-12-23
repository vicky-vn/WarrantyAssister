//  MainMenuView.swift
//  WarrantyAssister
//
//  Created by Vignesh Natarajan on 26/07/24.
//

import SwiftUI

struct MainMenuView: View {
    init() {
        // Customize the navigation bar title appearance
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: AddProductView()) {
                    Text("Add Product Info")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)
                }
                
                NavigationLink(destination: ViewProductInfo()) {
                    Text("View Product Info")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)
                }
            }
            .navigationTitle("Product Assister")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
