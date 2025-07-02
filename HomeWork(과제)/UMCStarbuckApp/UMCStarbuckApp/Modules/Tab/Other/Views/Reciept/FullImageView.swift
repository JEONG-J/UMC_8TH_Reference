//
//  FullImageView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import SwiftUI

/// 전체 화면에 이미지를 보여주는 뷰
struct FullImageView: View {
    
    // MARK: - Property
    
    /// 외부에서 주입받는 이미지 데이터
    let imageData: Data
    
    /// 뷰를 닫기 위한 dismiss 환경 값
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Constant
    
    /// 내부에서 사용하는 UI 관련 상수 정의
    fileprivate enum FullImageConstants {
        static let erroMessage: String = "이미지를 불러올 수 없어요"
        static let backgrounOpacity: Double = 0.8
        static let closeTopPadding: CGFloat = 18
        static let closeTrailingPadding: CGFloat = 16
    }
    
    // MARK: - Init
    
    /// 이미지 데이터를 주입받아 초기화
    init(imageData: Data) {
        self.imageData = imageData
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .center, content: {
            // 반투명 검정 배경
            Color.black.opacity(FullImageConstants.backgrounOpacity)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            // 이미지 콘텐츠
            imageContents
        })
    }
    
    /// 닫기 버튼 (오른쪽 상단에 위치)
    private var closeButton: some View {
        Button(action: {
            dismiss() // 시트 닫기
        }, label: {
            Image(.close)
                .padding(.top, FullImageConstants.closeTopPadding)
                .padding(.trailing, FullImageConstants.closeTrailingPadding)
        })
    }
    
    /// 이미지 렌더링 콘텐츠
    @ViewBuilder
    private var imageContents: some View {
        // 데이터로부터 UIImage 생성이 가능하면 표시
        if let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(alignment: .topTrailing, content: {
                    closeButton
                })
        } else {
            // 불러오기 실패 시 아무것도 표시하지 않음
            EmptyView()
        }
    }
}
