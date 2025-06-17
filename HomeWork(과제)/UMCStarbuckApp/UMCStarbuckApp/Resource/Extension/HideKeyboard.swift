//
//  HideKeyboard.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import Foundation
import SwiftUI

// UIApplication에 키보드를 숨기는 기능을 확장
extension UIApplication {
    
    /// 키보드를 숨기기 위한 탭 제스처를 윈도우에 추가하는 함수
    func hideKeyboard() {
        // 현재 활성화된 윈도우 씬을 가져옴
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            // 해당 씬의 첫 번째 윈도우를 가져옴
            guard let window = windowScene.windows.first else { return }
            
            // 뷰에서 포커스를 제거하여 키보드를 내리는 액션을 수행하는 탭 제스처 생성
            let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
            tapRecognizer.cancelsTouchesInView = false  // 기존 터치 이벤트가 무시되지 않도록 설정
            tapRecognizer.delegate = self  // 제스처 델리게이트를 UIApplication으로 설정
            
            // 제스처를 윈도우에 추가
            window.addGestureRecognizer(tapRecognizer)
        }
    }
}

// UIGestureRecognizerDelegate 프로토콜을 UIApplication에 레트로액티브하게 확장
extension UIApplication: @retroactive UIGestureRecognizerDelegate {
    
    /// 여러 제스처 인식기를 동시에 인식할 수 있을지 여부를 반환하는 메서드
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false  // 동시에 인식하지 않도록 설정
    }
}
