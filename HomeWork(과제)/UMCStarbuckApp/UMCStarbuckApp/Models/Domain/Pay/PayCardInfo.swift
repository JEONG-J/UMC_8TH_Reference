//
//  PayCardInfo.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/30/25.
//

import Foundation
import SwiftData

@Model
class PayCardInfo {
    @Attribute(.unique) var id: UUID
    var cardName: String
    var balance: Int
    var cardNumber: String
    var imageData: Data
    var createdAt: Date

    init(
        id: UUID = UUID(),
        cardName: String,
        balance: Int,
        cardNumber: String,
        imageData: Data
    ) {
        self.id = id
        self.cardName = cardName
        self.balance = balance
        self.cardNumber = cardNumber
        self.imageData = imageData
        self.createdAt = Date()
    }

    // MARK: - Computed Propertie
    
    var maskedCardNumber: String {
        let cleanNumber = cardNumber.replacingOccurrences(of: "-", with: "")
        guard cleanNumber.count == 12 else { return cardNumber }
        
        let prefix = "****-****"
        let suffix = cleanNumber.suffix(4)
        return "\(prefix)-\(suffix)"
    }
}
