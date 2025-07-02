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
    
    // MARK: - Constants
    
    /// 알림 레이아웃 및 텍스트 관련 상수 정의
    fileprivate enum StoreSearchConstants {
        static let corenrRadius: CGFloat = 6                            // 알림 배경의 코너 반경
        static let vSpacing: CGFloat = 16                               // VStack 내부 간격
        static let vStackBottomOffset: CGFloat = -13                    // VStack의 Y축 위치 조정값
        static let topDividerPadding: CGFloat = 2                       // Divider 위 패딩
        static let alertHeight: CGFloat = 118
        static let alertPadding: CGFloat = 32
        
        static let alertWarningText: String = "해당 검색어로 조회된 매장정보가 존재하지 않아요!"
        static let alertCheckText: String = "확인"
    }
    
    // MARK: - Init
    
    /// 외부에서 showAlert 상태를 주입받는 초기화
    init(showAlert: Binding<Bool>) {
        self._showAlert = showAlert
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
        VStack(spacing: StoreSearchConstants.vSpacing, content: {
            // 경고 텍스트
            Text(StoreSearchConstants.alertWarningText)
                .font(.mainTextSemiBold14)
                .foregroundStyle(Color.gray03)
            
            // 상단 Divider (경계선)
            Divider()
                .background(Color.gray01)
                .padding(.top, StoreSearchConstants.topDividerPadding)
            
            // 확인 버튼 (알림 닫기)
            Button(action: {
                showAlert.toggle()
            }, label: {
                Text(StoreSearchConstants.alertCheckText)
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(Color.green02)
            })
        })
        .offset(y: StoreSearchConstants.vStackBottomOffset) // 살짝 위로 올려서 정렬
    }
}

#Preview {
    StoreSearchAlert(showAlert: .constant(true))
}
