//
//  NavigationManager.swift
//  WarrantyAssister
//
//  Created by Vignesh Natarajan on 26/07/24.
//

import SwiftUI

class NavigationManager: ObservableObject {
    enum Destination {
        case mainMenu
        case addProduct
        case viewProductInfo
    }

    @Published var currentDestination: Destination = .mainMenu

    func navigate(to destination: Destination) {
        currentDestination = destination
    }
}
