//
//  WarrantyStorage.swift
//  WarrantyAssister
//
//  Created by Vignesh Natarajan on 26/07/24.
//

import Foundation
import SwiftUI
import Combine
import PDFKit

class WarrantyStorage: ObservableObject {
    @Published var warranties: [Warranty] = []
    
    init() {
        // Load data from UserDefaults or other storage mechanism
        loadData()
    }

    func add(warranty: Warranty) {
        warranties.append(warranty)
        saveData()
    }

    func update(warranty: Warranty) {
        if let index = warranties.firstIndex(where: { $0.id == warranty.id }) {
            warranties[index] = warranty
            saveData()
        }
    }

    func delete(warranty: Warranty) {
        warranties.removeAll { $0.id == warranty.id }
        saveData()
    }

    private func loadData() {
        if let data = UserDefaults.standard.data(forKey: "warranties") {
            if let decoded = try? JSONDecoder().decode([Warranty].self, from: data) {
                warranties = decoded
            }
        }
    }

    private func saveData() {
        if let encoded = try? JSONEncoder().encode(warranties) {
            UserDefaults.standard.set(encoded, forKey: "warranties")
        }
    }

    func generatePDF() -> Data {
        let pdfMetaData = [
            kCGPDFContextCreator: "Warranty Assister",
            kCGPDFContextAuthor: "Your Name",
            kCGPDFContextTitle: "Warranty Report"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { (context) in
            context.beginPage()
            
            let title = "Warranty Report"
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 18)
            ]
            title.draw(at: CGPoint(x: 20, y: 20), withAttributes: titleAttributes)
            
            var yPosition = 50
            
            for warranty in warranties {
                let warrantyText = """
                Product Name: \(warranty.name)
                Category: \(warranty.category)
                Store: \(warranty.store)
                Warranty Period: \(warranty.warrantyPeriod) days
                Return Period: \(warranty.returnPeriod) days
                Purchase Date: \(warranty.purchaseDate)
                Remaining Return Period: \(daysRemaining(for: warranty.returnPeriod, from: warranty.purchaseDate)) days
                Remaining Warranty Period: \(daysRemaining(for: warranty.warrantyPeriod, from: warranty.purchaseDate)) days
                """
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 12)
                ]
                warrantyText.draw(at: CGPoint(x: 20, y: yPosition), withAttributes: attributes)
                yPosition += 100
            }
        }
        
        return data
    }
    
    private func daysRemaining(for period: Int, from date: Date) -> Int {
        let endDate = Calendar.current.date(byAdding: .day, value: period, to: date)!
        let remainingDays = Calendar.current.dateComponents([.day], from: Date(), to: endDate).day ?? 0
        return max(remainingDays, 0)
    }
}
