//
//  CustomShadow.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

struct Shadow01: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 1)
    }
}

struct BtnShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.04), radius: 3.5, x: 0, y: -3)
    }
}

extension View {
    func shadow01() -> some View {
        self.modifier(Shadow01())
    }
    
    func btnShadow() -> some View {
        self.modifier(BtnShadow())
    }
}
