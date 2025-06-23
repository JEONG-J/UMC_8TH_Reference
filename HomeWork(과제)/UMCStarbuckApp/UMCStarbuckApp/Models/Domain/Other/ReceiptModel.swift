import Foundation
import SwiftData

@Model
class ReceiptModel: Identifiable {
    @Attribute(.unique) var id: UUID
    var stroeName: String
    var date: Date
    var price: Int
    var createdAt: Date
    var imageData: Data?
    
    init(
        id: UUID = .init(),
        stroeName: String,
        date: Date,
        price: Int,
        createdAt: Date,
        imageData: Data? = nil
    ) {
        self.id = id
        self.stroeName = stroeName
        self.date = date
        self.price = price
        self.createdAt = createdAt
        self.imageData = imageData
    }
}
