//
//  FullADView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import SwiftUI

/// 전체 화면 광고 뷰
struct FullADView: View {
    
    // MARK: - Property
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Constants
    
    /// 광고 뷰에 사용되는 상수 정의
    fileprivate enum FullADVConstants {
        static let mainButtonText: String = "자세히 보기"      // 메인 버튼 텍스트
        static let closeText: String = "X 닫기"               // 닫기 버튼 텍스트
        
        static let adImageHeight: CGFloat = 720               // 광고 이미지 높이
        static let mainButtonHeight: CGFloat = 58             // 메인 버튼 높이
        static let spcingPadding: CGFloat = 19                // 버튼과 텍스트 간 간격
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            topContents    
            Spacer()        
            bottomContents 
        }
        .safeAreaPadding(.horizontal, UIConstants.defaultHorizontalPadding)
    }
    
    // MARK: - TopContents
    
    /// 상단 광고 이미지 뷰
    private var topContents: some View {
        Image(.fullAd) // 사진이 오른쪽면 이상하게 짤린걸로 피그마에 올려뒀었어요! 그래서 옆에 이상한 파란색 보이는건 틀린게 아님!
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: FullADVConstants.adImageHeight)
            .aspectRatio(contentMode: .fit)
            .ignoresSafeArea()
    }
    
    // MARK: - BottomContents
    
    /// 하단 버튼 영역 (자세히 보기, 닫기 버튼)
    private var bottomContents: some View {
        VStack(alignment: .trailing, spacing: FullADVConstants.spcingPadding, content: {
            MainButton(
                color: Color.green01,
                text: FullADVConstants.mainButtonText,
                height: FullADVConstants.mainButtonHeight,
                action: {
                    print("자세히 보기")
                }
            )
            closeButton
        })
        .safeAreaPadding(.horizontal, UIConstants.defaultHorizontalPadding)
    }
    
    /// 광고 닫기 버튼
    private var closeButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Text(FullADVConstants.closeText)
                .font(.mainTextLight14)
                .foregroundStyle(Color.gray05)
                .padding(.trailing, FullADVConstants.spcingPadding)
        })
    }
}

#Preview {
    FullADView()
}
