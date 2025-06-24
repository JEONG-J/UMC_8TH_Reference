//
//  CoffeeMenuItem.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import Foundation
import SwiftUI

enum OrderCoffeeMenu: String, CaseIterable, Identifiable {
    case recommend = "추천"
    case iceAmericano = "아이스 카페 아메리카노"
    case hotAmericano = "카페 아메리카노"
    case cappuccino = "카푸치노"
    case iceCappuccino = "아이스 카푸치노"
    case caramelMacchiato = "카라멜 마끼아또"
    case iceCaramelMacchiato = "아이스 카라멜 마끼아또"
    case apogato = "아포가토/기타"
    case rumShotCortado = "럼 샷 코르타도"
    case lavenderCafeBrevet = "라벤터 카페 브레베"
    case bottledBeverages = "병 음료"
    
    var id: String { self.rawValue }
    
    var image: ImageResource {
        switch self {
        case .recommend:
            return .macchiatoCircle
        case .iceAmericano:
            return .americanoIceCircle
        case .hotAmericano:
            return .americanoHotCircle
        case .cappuccino:
            return .cappuccino
        case .iceCappuccino:
            return .iceCappuccino
        case .caramelMacchiato:
            return .macchiatoHotCircle
        case .iceCaramelMacchiato:
            return .macchiatoIceCircle
        case .apogato:
            return .apogato
        case .rumShotCortado:
            return .rumShotCortado
        case .lavenderCafeBrevet:
            return .lavenderCafeBrevet
        case .bottledBeverages:
            return .bottledBeverages
        }
    }
    
    var english: String {
        switch self {
        case .recommend:
            return "Recommend"
        case .iceAmericano:
            return "Reserve Espresso"
        case .hotAmericano:
            return "Reserve Drip"
        case .cappuccino:
            return "Dcaf Coffee"
        case .iceCappuccino:
            return "Espressso"
        case .caramelMacchiato:
            return "Blonde Coffee"
        case .iceCaramelMacchiato:
            return "Cold Brew"
        case .apogato:
            return "Others"
        case .rumShotCortado:
            return "Brewed Coffee"
        case .lavenderCafeBrevet:
            return "Teavana"
        case .bottledBeverages:
            return "RTD"
        }
    }
    
    var greenMark: Bool {
        switch self {
        case .recommend:
            return true
        case .iceAmericano:
            return true
        case .hotAmericano:
            return true
        case .iceCappuccino:
            return true
        case .caramelMacchiato:
            return true
        case .iceCaramelMacchiato:
            return true
        case .rumShotCortado:
            return true
        case .lavenderCafeBrevet:
            return true
        default:
            return false
        }
    }
}
