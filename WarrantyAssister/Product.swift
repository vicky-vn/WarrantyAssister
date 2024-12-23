//
//  Product.swift
//  WarrantyAssister
//
//  Created by Vignesh Natarajan on 26/07/24.
//

import SwiftData
import Foundation

@Model
class Warranty {
    @Attribute(.primaryKey) var id: UUID
    var name: String
    var category: String
    var store: String
    var warrantyPeriod: Int

    init(id: UUID = UUID(), name: String, category: String, store: String, warrantyPeriod: Int) {
        self.id = id
        self.name = name
        self.category = category
        self.store = store
        self.warrantyPeriod = warrantyPeriod
    }
}

