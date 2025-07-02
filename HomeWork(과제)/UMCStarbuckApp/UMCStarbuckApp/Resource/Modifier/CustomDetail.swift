//
//  CustomDetail.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/30/25.
//

import SwiftUI

// MARK: - ViewModifier 정의
struct CustomDetail: ViewModifier {
    let overlayContents: AnyView?
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if let overlay = overlayContents {
                        ZStack {
                            Color.black.opacity(0.5).ignoresSafeArea()
                            overlay
                        }
                    }
                }
            )
    }
}

// MARK: - View 확장 메서드
extension View {
    func customDetail<Content: View>(@ViewBuilder content: () -> Content?) -> some View {
        let view = content().map { AnyView($0) }
        return self.modifier(CustomDetail(overlayContents: view))
    }
}
