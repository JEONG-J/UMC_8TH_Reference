//
//  CustomDetail.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/30/25.
//

import SwiftUI

// MARK: - ViewModifier 정의
struct CustomDetail: ViewModifier {
    let overlayContents: AnyView

    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    Color.black.opacity(0.5).ignoresSafeArea()
                    overlayContents
                }
            )
    }
}

// MARK: - View 확장 메서드
extension View {
    func customDetail<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        self.modifier(CustomDetail(overlayContents: AnyView(content())))
    }
}
