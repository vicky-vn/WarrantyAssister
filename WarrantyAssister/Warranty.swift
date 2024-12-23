//
//  Warranty.swift
//  WarrantyAssister
//
//  Created by Vignesh Natarajan on 26/07/24.
//

import Foundation

struct Warranty: Identifiable, Codable {
    var id = UUID()
    var name: String
    var category: String
    var store: String
    var warrantyPeriod: Int
    var returnPeriod: Int
    var purchaseDate: Date
}
