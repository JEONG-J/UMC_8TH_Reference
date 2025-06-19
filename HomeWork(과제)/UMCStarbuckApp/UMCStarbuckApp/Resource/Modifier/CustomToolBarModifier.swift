//
//  CustomToolBarModifier.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation
import SwiftUI

/// 재사용 가능한 커스텀 툴바 Modifier
/// - 뒤로가기 버튼 (leading)과 선택적인 중앙 타이틀 (principal)을 포함함
struct CustomToolBarModifier: ViewModifier {
    
    /// 툴바에 표시할 타이틀 (없을 수도 있음)
    let title: String?
    
    /// 뒤로가기 버튼 액션
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar(content: {
                
                /// 왼쪽에 표시되는 뒤로가기 버튼
                ToolbarItem(placement: .topBarLeading, content: {
                    Button(action: {
                        action()
                    }, label: {
                        Image(.leftChevron)
                            .fixedSize()
                    })
                })
                
                /// 중앙에 표시될 타이틀 (옵셔널)
                if let title = title {
                    ToolbarItem(placement: .principal, content: {
                        Text(title)
                            .font(.mainTextMedium16)
                            .foregroundStyle(Color.black)
                    })
                }
            })
    }
}

extension View {
    
    /// 커스텀 네비게이션 툴바를 뷰에 적용하는 Modifier
    ///
    /// - Parameters:
    ///   - title: 툴바에 표시할 타이틀 (선택 사항, nil일 경우 중앙 타이틀 없음)
    ///   - action: 뒤로가기 버튼을 눌렀을 때 실행될 액션
    /// - Returns: 커스텀 툴바가 적용된 뷰
    func customNavigation(title: String? = nil, action: @escaping () -> Void) -> some View {
        self.modifier(CustomToolBarModifier(title: title, action: action))
    }
}
