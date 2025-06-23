//
//  OffsetModifier.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//
import Foundation
import SwiftUI

struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    
    var returnromStart: Bool = true
    @State var startValue: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(content: {
                GeometryReader(content: { proxy in
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")).minY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            if startValue == 0 {
                                startValue = value
                            }
                            
                            offset = (value - (returnromStart ? startValue : 0))
                        }
                })
            })
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
