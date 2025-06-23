//
//  PaySupport.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import Foundation
import SwiftUI

enum PayType: String, OtherMenuButton {
    case registerCard = "스타벅스 카드 등록"
    case registerVoucher = "카드 교환권 등록"
    case registerCoupon = "쿠폰 등록"
    case couponHistory = "쿠폰 히스토리"
    
    var id: String { rawValue }
    
    var title: String { rawValue }
    
    var icon: ImageResource {
        switch self {
        case .registerCard:
            return .card
        case .registerVoucher:
            return .cardChange
        case .registerCoupon:
            return .coupon
        case .couponHistory:
            return .couponHistory
        }
    }
}

enum SupportType: String, OtherMenuButton {
    case storeCare = "스토어 케어"
    case customerVoice = "고객의 소리"
    case storeInfo = "매장 정보"
    case returnInfo = "반납기 정보"
    case myReview = "마이 스타벅스 리뷰"
    
    var title: String { rawValue}
    
    var id: String { rawValue }
    
    var icon: ImageResource {
        switch self {
        case .storeCare:
            return .storeCare
        case .customerVoice:
            return .customer
        case .storeInfo:
            return .storeInfo
        case .returnInfo:
            return .returnInfo
        case .myReview:
            return .myReview
        }
    }
}
