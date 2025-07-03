//
//  StoreSearchAlert.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/30/25.
//

import SwiftUI

/// 매장 검색 시 결과가 없을 경우 하단에 표시되는 커스텀 알림 뷰입니다.
/// - 텍스트 메시지와 확인 버튼으로 구성되며,
/// - `showAlert` 바인딩을 통해 외부에서 표시 여부를 제어할 수 있습니다.
struct StoreSearchAlert: View {
    
    // MARK: - Property
    
    /// 알림 표시 여부를 제어하는 외부 바인딩 값
    @Binding var showAlert: Bool
    
    /// Alert 타입
    let position: RoutePosition
    
    // MARK: - Constants
    
    /// 알림 레이아웃 및 텍스트 관련 상수 정의
    fileprivate enum StoreSearchConstants {
        static let corenrRadius: CGFloat = 6                            // 알림 배경의 코너 반경
        static let vSpacing: CGFloat = 18                              // VStack 내부 간격
        static let bottomPadding: CGFloat = 13
        static let topPadding: CGFloat = 16
        
        static let alertHeight: CGFloat = 118
        static let alertPadding: CGFloat = 32
        
        static let alertCheckText: String = "확인"
    }
    
    // MARK: - Init
    
    /// 외부에서 showAlert 상태를 주입받는 초기화
    init(showAlert: Binding<Bool>, position: RoutePosition) {
        self._showAlert = showAlert
        self.position = position
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            // 알림 배경
            RoundedRectangle(cornerRadius: StoreSearchConstants.corenrRadius)
                .fill(Color.white01)
                .alertShadow() // 그림자 효과 (사용자 정의 modifier)
            
            // 내부 콘텐츠 (텍스트 + 버튼)
            contents
        })
        .frame(maxWidth: .infinity, maxHeight: StoreSearchConstants.alertHeight)
        .padding(.horizontal, StoreSearchConstants.alertPadding)
    }
    
    /// 경고 메시지 + Divider + 확인 버튼 구성
    private var contents: some View {
        VStack(spacing: .zero, content: {
            // 경고 텍스트
            Text(position.alertMessage)
                .font(.mainTextSemiBold14)
                .foregroundStyle(Color.gray03)
                .padding(.bottom, StoreSearchConstants.vSpacing)
            
            // 상단 Divider (경계선)
            Divider()
                .background(Color.gray01)
            
            // 확인 버튼 (알림 닫기)
            Button(action: {
                showAlert.toggle()
            }, label: {
                Text(StoreSearchConstants.alertCheckText)
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(Color.green02)
                    .frame(maxWidth: .infinity)
                    .padding(.top, StoreSearchConstants.topPadding)
                    .padding(.bottom, StoreSearchConstants.bottomPadding)
            })
        })
    }
}
