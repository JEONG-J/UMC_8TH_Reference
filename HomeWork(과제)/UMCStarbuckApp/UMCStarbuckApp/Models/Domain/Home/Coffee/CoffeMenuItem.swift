//
//  CoffeMenuItem.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/20/25.
//

import Foundation
import SwiftUI

struct CoffeeMenuItem: Identifiable {
    let id: UUID
    let name: String
    let subName: String
    let price: Int
    let variants: [CoffeeTemperature: CoffeeVariant]
    
    var temperatureLabel: String {
        let temps = Set(availableTemperatures)
        if temps == [.hot] {
            return "HOT Only"
        } else if temps == [.iced] {
            return "ICED Only"
        } else {
            return ""
        }
    }
    
    var availableTemperatures: [CoffeeTemperature] {
        Array(variants.keys)
    }
    
    func variants(temp: CoffeeTemperature) -> CoffeeVariant? {
        variants[temp]
    }
}

struct CoffeeVariant {
    let image: ImageResource
    let description: String
}
