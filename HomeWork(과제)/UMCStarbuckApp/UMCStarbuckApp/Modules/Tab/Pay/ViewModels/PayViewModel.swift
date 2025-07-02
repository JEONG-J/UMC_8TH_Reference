//
//  PayViewModels.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/30/25.
//

import Foundation
import SwiftUI

@Observable
class PayViewModel {
    // MARK: - StateProperty
    var showAddCard: Bool = false
    // MARK: - Property
    var remainingTime: TimeInterval = 180
    var selectedIndex: Int = 0 {
        didSet {
            resetTimerSelectCard()
        }
    }
    var formattedTime: String {
            let minutes = Int(remainingTime) / 60
            let seconds = Int(remainingTime) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
    
    var container: DIContainer
    private var timer: Timer?
    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
        resetTimerSelectCard()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    // MARK: - Timer
    private func resetTimerSelectCard() {
        timer?.invalidate()
        remainingTime = 180
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            self?.tick()
        })
    }
    
    private func tick() {
        if remainingTime > 0 {
            remainingTime -= 1
        } else {
            timer?.invalidate()
        }
    }
}
