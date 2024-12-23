//
//  Item.swift
//  WarrantyAssister
//
//  Created by Vignesh Natarajan on 26/07/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
