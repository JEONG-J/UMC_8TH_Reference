//
//  NavigationDestination.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import Foundation

enum NavigationDestination: Equatable, Hashable {
    case signUp
    case coffeeDetail(id: UUID)
    case receiptView
}
