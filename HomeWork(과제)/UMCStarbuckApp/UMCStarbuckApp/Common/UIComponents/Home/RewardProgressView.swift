//
//  RewardProgressView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import SwiftUI

/// 리워드 진행률을 시각화하는 뷰
struct RewardProgressView: View {
    
    // MARK: - Property
    
    /// 보상을 받기 위한 총 별 개수 (기본값 12)
    var totalStars: Int = 12
    
    /// 현재까지 획득한 별 개수 (기본값 1)
    var currentStars: Int = 1
    
    /// 표시될 리워드 문구
    var rewardText: String {
        "\(totalStars - currentStars)★ until next Reward"
    }
    
    /// 현재 진행률 (0.0 ~ 1.0)
    var progressValue: Double {
        Double(currentStars) / Double(totalStars)
    }
    
    /// 내부 레이아웃 관련 상수
    fileprivate enum RewardProgressConstants {
        static let progressAllWidth: CGFloat = 370
        static let progressBarWidth: CGFloat = 255
        static let progressHeight: CGFloat = 8             // 프로그레스 바 높이
        static let rewardSpacing: CGFloat = 5              // 텍스트와 바 간 간격
        static let cornerRadius: CGFloat = 4               // 둥근 모서리 반지름
        
        static let stars: String = "★"
    }

    // MARK: - Body
    
    var body: some View {
        HStack(content: {
            progressBar
            Spacer()
            progressInfo
        })
        .frame(maxWidth: RewardProgressConstants.progressAllWidth, alignment: .leading)
    }
    
    private var progressBar: some View {
        VStack(alignment: .leading, spacing: RewardProgressConstants.rewardSpacing, content: {
            // 리워드 남은 별 표시 텍스트
            Text(rewardText)
                .font(.mainTextSemiBold16)
                .foregroundStyle(Color.brown02) // 브라운 계열 텍스트 색상
            
            // 프로그레스 바
            ZStack(alignment: .leading, content: {
                // 배경 바 (전체 길이 기준)
                RoundedRectangle(cornerRadius: RewardProgressConstants.cornerRadius)
                    .frame(height: RewardProgressConstants.progressHeight)
                    .foregroundStyle(Color.gray07)
                
                // 진행 바 (비율에 따라 채워짐)
                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: RewardProgressConstants.cornerRadius)
                        .frame(
                            width: geo.size.width * progressValue,
                            height: RewardProgressConstants.progressHeight
                        )
                        .foregroundStyle(Color.brown01)
                }
            })
            .frame(width: RewardProgressConstants.progressBarWidth, height: RewardProgressConstants.progressHeight) // 바 높이 고정
        })
    }
    
    private var progressInfo: some View {
        HStack(spacing: RewardProgressConstants.rewardSpacing, content: {
            Text("\(currentStars)")
                .font(.mainTextSemiBold38)
                .foregroundStyle(Color.black03)
            
            Text("/")
                .font(.mainTextLight24)
                .foregroundStyle(Color.gray03)
            
            Text(convertStyleText("\(totalStars)\(RewardProgressConstants.stars)"))
                .font(.mainTextSemiBold24)
                .foregroundStyle(Color.brown02)
        })
    }
    
    private func convertStyleText(_ text: String) -> AttributedString {
        var attributedString = AttributedString(text)
        
        if let starRange = attributedString.range(of: RewardProgressConstants.stars) {
            attributedString[starRange].foregroundColor = Color.brown02
            attributedString[starRange].font = .mainTextSemiBold14
        }
        
        return attributedString
    }
}

#Preview {
    RewardProgressView()
}
