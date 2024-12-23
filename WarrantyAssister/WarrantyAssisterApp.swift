//
//  WarrantyAssisterApp.swift
//  WarrantyAssister
//
//  Created by Vignesh Natarajan on 26/07/24.

import SwiftUI

@main
struct WarrantyAssisterApp: App {
    @StateObject private var warrantyStorage = WarrantyStorage()
    @StateObject private var navigation = NavigationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(warrantyStorage)
                .environmentObject(navigation)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var navigation: NavigationManager

    var body: some View {
        NavigationView {
            VStack {
                switch navigation.currentDestination {
                case .mainMenu:
                    MainMenuView()
                case .addProduct:
                    AddProductView()
                case .viewProductInfo:
                    ViewProductInfo()
                }
                Spacer()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Ensures the navigation style is consistent
    }
}
