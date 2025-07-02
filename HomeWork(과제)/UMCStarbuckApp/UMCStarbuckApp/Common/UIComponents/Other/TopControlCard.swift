//
//  TopControlButton.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import SwiftUI

/// 홈 또는 기타 화면의 상단에서 사용되는 컨트롤 카드 컴포넌트입니다.
/// - 이미지 + 텍스트로 구성된 버튼 형태
/// - 버튼 터치 시 `TopControlType`에 따라 동작 분기 가능
struct TopControlCard: View {
    
    // MARK: - Property
    
    /// 현재 카드의 타입 (아이콘, 텍스트, 스타일 결정)
    let type: TopControlType
    
    /// 버튼이 눌렸을 때 실행할 클로저 (선택된 타입 전달)
    let action: (TopControlType) -> Void
    
    // MARK: - Constants
    
    /// 레이아웃 및 스타일에 사용할 상수 정의
    fileprivate enum TopControlCardConstant {
        static let cornerRadius: CGFloat = 15     // 카드 모서리 라운드
        static let spacing: CGFloat = 4           // 이미지와 텍스트 간 간격
    }
    
    // MARK: - Init
    
    /// 카드의 타입과 터치 이벤트 핸들러를 주입받는 초기화 메서드
    init(type: TopControlType, action: @escaping (TopControlType) -> Void) {
        self.type = type
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        Button(action: {
            action(type) // 버튼 터치 시 선택된 타입 전달
        }, label: {
            ZStack {
                // 카드 배경
                RoundedRectangle(cornerRadius: TopControlCardConstant.cornerRadius)
                    .fill(Color.white)
                    .otherShadow() // 그림자 효과 (사용자 정의 Modifier)
                
                // 내부 콘텐츠 (이미지 + 텍스트)
                contents
            }
        })
    }
    
    /// 카드 내부 콘텐츠: 이미지와 텍스트 수직 배치
    private var contents: some View {
        VStack(spacing: TopControlCardConstant.spacing, content: {
            Image(type.image)                // 아이콘 이미지
            Text(type.rawValue)             // 타이틀 텍스트
                .font(type.font)            // 타입별 폰트 스타일
                .foregroundStyle(type.color) // 타입별 색상
        })
    }
}

#Preview {
    // 미리보기: `.myMenu` 타입을 사용한 카드, 탭 시 콘솔 출력
    TopControlCard(type: .myMenu, action: { _ in
        print("카드 눌림")
    })
}
