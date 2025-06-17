//
//  GetScreenSize.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import Foundation
import SwiftUI

// SwiftUI의 View에 화면 크기를 가져오는 기능을 확장
extension View {
    
    /// 현재 기기의 화면 크기를 반환하는 함수
    ///
    /// - Returns: 화면의 너비와 높이를 담은 CGSize. 실패 시 .zero 반환
    func getScreenSize() -> CGSize {
        // 현재 활성화된 UIWindowScene을 가져옴
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            // 실패할 경우 기본값(.zero)을 반환
            return .zero
        }
        // 해당 윈도우 씬의 화면 크기를 반환
        return windowScene.screen.bounds.size
    }
}
