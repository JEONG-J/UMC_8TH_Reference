//
//  CustomToolBarModifier.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation
import SwiftUI

/// 재사용 가능한 커스텀 툴바 Modifier
/// - 뒤로가기 버튼 (leading), 중앙 타이틀 (principal), 오른쪽 버튼 (trailing)을 포함함
struct CustomToolBarModifier: ViewModifier {
    
    let title: String?
    let leadingAction: () -> Void
    let trailingAction: (() -> Void)?
    
    let bottomPadding: CGFloat = 22
    let topPadding: CGFloat = 11
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                // 왼쪽: 뒤로가기
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: leadingAction) {
                        Image(.leftChevron)
                            .fixedSize()
                    }
                    .padding(.bottom, bottomPadding)
                    .padding(.top, topPadding)
                }
                
                // 가운데 타이틀
                if let title = title {
                    ToolbarItem(placement: .principal) {
                        Text(title)
                            .font(.mainTextMedium16)
                            .foregroundStyle(Color.black)
                            .padding(.bottom, bottomPadding)
                            .padding(.top, topPadding)
                    }
                }
                
                // 오른쪽 버튼
                if let action = trailingAction {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: action) {
                            Image(.plusIcon)
                                .fixedSize()
                        }
                        .padding(.bottom, bottomPadding)
                        .padding(.top, topPadding)
                    }
                }
            }
    }
}

extension View {
    
    /// 커스텀 네비게이션 툴바를 뷰에 적용하는 Modifier
    ///
    /// - Parameters:
    ///   - title: 툴바 중앙 타이틀 (선택 사항)
    ///   - leadingAction: 뒤로가기 버튼을 눌렀을 때 실행할 액션
    ///   - trailingIcon: 오른쪽 버튼에 표시할 이미지 (선택 사항)
    ///   - trailingAction: 오른쪽 버튼 터치 시 실행될 액션 (선택 사항)
    func customNavigation(
        title: String? = nil,
        leadingAction: @escaping () -> Void,
        trailingAction: (() -> Void)? = nil
    ) -> some View {
        self.modifier(
            CustomToolBarModifier(
                title: title,
                leadingAction: leadingAction,
                trailingAction: trailingAction
            )
        )
    }
}
