//
//  CoffeeDetailViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import Foundation

@Observable
class CoffeeDetailViewModel {
    let coffee: CoffeeMenuItem
    var selectredTemperature: CoffeeTemperature
    
    init(coffee: CoffeeMenuItem) {
        self.coffee = coffee
        self.selectredTemperature = coffee.availableTemperatures.first ?? .iced
    }
    
    var selectedVariant: CoffeeVariant? {
        coffee.variants(temp: selectredTemperature)
    }
    
    var currentName: String {
        if let tempNames = coffee.temperatureNames,
           let name = tempNames[selectredTemperature]?.0 {
            return name
        }
        return coffee.name
    }

    var currentSubName: String {
        if let tempNames = coffee.temperatureNames,
           let subName = tempNames[selectredTemperature]?.1 {
            return subName
        }
        return coffee.subName
    }
}
