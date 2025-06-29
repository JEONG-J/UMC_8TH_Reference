//
//  TemperatureToggleView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

/// 온도 선택 토글 뷰 (예: HOT / ICED)
struct TemperatureToggleView: View {
    
    // MARK: - Property
    
    /// 현재 선택된 온도 (상위에서 바인딩됨)
    @Binding var selected: CoffeeTemperature
    
    /// 선택 가능한 온도 목록 (예: [.hot, .iced])
    let available: [CoffeeTemperature]
    
    /// 선택 애니메이션을 위한 네임스페이스
    @Namespace private var animation
    
    // MARK: - Constants
    
    /// 내부에서 사용하는 UI 상수 모음
    fileprivate enum TemperatureToggleConstants {
        static let buttonHeight: CGFloat = 36         // 버튼 높이
        static let cornerRadius: CGFloat = 999        // 토글 영역 둥근 정도 (완전 둥글게)
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: .zero, content: {
            // 온도 항목별로 버튼 생성
            ForEach(available, id: \.self) { temp in
                toogleButton(temp)
            }
        })
        // 전체 배경 (회색 둥근 배경)
        .background {
            RoundedRectangle(cornerRadius: TemperatureToggleConstants.cornerRadius)
                .fill(Color.gray07)
        }
    }
    
    /// 각 온도 항목에 해당하는 버튼 뷰
    private func toogleButton(_ temp: CoffeeTemperature) -> some View {
        Button(action: {
            withAnimation {
                selected = temp
            }
        }, label: {
            Text(temp.rawValue) // "HOT" 또는 "ICED"
                .font(.mainTextSemiBold18)
                .foregroundStyle(selected == temp ? selectedColor(for: temp) : .gray02)
                .frame(maxWidth: .infinity, minHeight: TemperatureToggleConstants.buttonHeight)
                .background {
                    ZStack {
                        // 선택된 버튼에는 흰색 배경 + 그림자 + matchedGeometryEffect 적용
                        if selected == temp {
                            Capsule()
                                .fill(Color.white)
                                .shadow01()
                                .matchedGeometryEffect(id: "underline", in: animation)
                        }
                    }
                }
        })
    }
    
    /// 선택된 온도에 따라 다른 강조 색상 제공
    private func selectedColor(for temp: CoffeeTemperature) -> Color {
        switch temp {
        case .hot:
            return .red01
        case .iced:
            return .blue01
        }
    }
}

// 프리뷰 설정: HOT / ICED 버튼이 표시되고 HOT이 선택된 상태
#Preview {
    TemperatureToggleView(selected: .constant(.hot), available: [
        .hot, .iced
    ])
}
