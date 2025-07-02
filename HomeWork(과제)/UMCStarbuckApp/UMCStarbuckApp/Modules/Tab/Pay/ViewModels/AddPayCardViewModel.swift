//
//  AddPayCardViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/1/25.
//

import Foundation

@Observable
class AddPayCardViewModel {
    let maxCardNameCount: Int = 20
    let maxCardNumberCount: Int = 12
    let container: DIContainer
    
    // MARK: - CardInfo
    var cardName: String = "" {
        didSet {
            if cardName.count > maxCardNameCount {
                cardName = String(cardName.prefix(maxCardNameCount))
            }
        }
    }
    var cardNumber: String = "" {
        didSet {
            if cardNumber.count > maxCardNumberCount {
                cardNumber = String(cardNumber.prefix(maxCardNumberCount))
            }
        }
    }
    var randomBalance: Int {
        Int.random(in: 0...100_000_000_000)
    }
    
    init(container: DIContainer) {
        self.container = container
    }
}
