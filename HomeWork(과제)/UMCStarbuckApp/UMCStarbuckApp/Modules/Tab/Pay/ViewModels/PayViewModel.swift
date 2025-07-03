//
//  PayViewModels.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/30/25.
//

import Foundation
import SwiftUI

/// Pay 화면에서 사용할 ViewModel
@Observable
class PayViewModel {
    
    // MARK: - UI 상태 변수
    
    /// 카드 추가 뷰를 보여줄지 여부
    var showAddCard: Bool = false
    
    // MARK: - 속성
    
    /// 현재 선택된 카드의 남은 유효 시간 (초 단위)
    var remainingTime: TimeInterval = 180
    
    /// 선택된 카드의 인덱스
    var selectedIndex: Int = 0 {
        didSet {
            // 카드가 변경되면 타이머 초기화
            resetTimerSelectCard()
        }
    }
    
    /// 남은 시간을 "MM:SS" 형식의 문자열로 반환
    var formattedTime: String {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    /// 의존성 주입을 위한 DIContainer
    var container: DIContainer
    
    /// 내부에서 사용하는 타이머 객체
    private var timer: Timer?
    
    // MARK: - 초기화
    
    /// DIContainer를 받아 초기화
    init(container: DIContainer) {
        self.container = container
        resetTimerSelectCard()
    }
    
    /// 뷰모델이 해제될 때 타이머 정리
    deinit {
        timer?.invalidate()
    }
    
    // MARK: - 타이머 관련 메서드
    
    /// 선택된 카드가 변경되면 타이머를 재설정
    private func resetTimerSelectCard() {
        // 기존 타이머 무효화
        timer?.invalidate()
        // 타이머 초기화
        remainingTime = 180
        // 1초 간격으로 tick() 호출
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            self?.tick()
        })
    }
    
    /// 매 초마다 호출되어 남은 시간 감소
    private func tick() {
        if remainingTime > 0 {
            remainingTime -= 1
        } else {
            timer?.invalidate()  // 시간이 0이 되면 타이머 종료
        }
    }
}
