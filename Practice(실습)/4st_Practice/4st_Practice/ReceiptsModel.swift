//
//  ReceiptsModel.swift
//  4st_Practice
//
//  Created by Apple Coding machine on 4/1/25.
//

import Foundation
import SwiftData

@Model
class ReceiptsModel {
    @Attribute(.unique) var id: UUID // 고유 식별자 ( 데이터베이스의 기본키처럼 동작합니다 )
    
    var orderer: String // 주문자
    var store: String // 장소
    var menuItems: [String] // 마신 음료
    var totalAmount: Int         // 결제 금액
    var orderNumber: String      // 주문번호
    var createdAt: Date          // 저장된 시점
    
    init(
            orderer: String,
            store: String,
            menuItems: [String],
            totalAmount: Int,
            orderNumber: String,
            createdAt: Date = Date()
        ) {
            self.id = UUID()
            self.orderer = orderer
            self.store = store
            self.menuItems = menuItems
            self.totalAmount = totalAmount
            self.orderNumber = orderNumber
            self.createdAt = createdAt
        }
}
