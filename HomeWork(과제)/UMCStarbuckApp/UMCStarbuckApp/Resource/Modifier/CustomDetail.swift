//
//  CustomDetail.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/30/25.
//

import SwiftUI

/// 뷰 위에 커스텀 오버레이(예: 모달, 로딩 뷰 등)를 덧씌우는 `ViewModifier`
struct CustomDetail: ViewModifier {
    /// 오버레이로 보여줄 뷰 (AnyView로 타입 지움)
    let overlayContents: AnyView?
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    // overlayContents가 존재하면 오버레이 표시
                    if let overlay = overlayContents {
                        ZStack {
                            // 반투명한 검은 배경을 전체에 적용
                            Color.black.opacity(0.5).ignoresSafeArea()
                            // 전달된 오버레이 뷰 표시
                            overlay
                        }
                    }
                }
            )
    }
}

// MARK: - View 확장 메서드

extension View {
    /// 해당 뷰 위에 커스텀 오버레이 뷰를 덧씌우는 메서드
    /// - Parameter content: 오버레이로 표시할 뷰 (ViewBuilder를 사용하여 조건부 표현 가능)
    /// - Returns: 오버레이가 적용된 뷰
    func customDetail<Content: View>(@ViewBuilder content: () -> Content?) -> some View {
        // content가 nil일 수 있으므로 AnyView로 변환하고 nil 처리
        let view = content().map { AnyView($0) }
        return self.modifier(CustomDetail(overlayContents: view))
    }
}
