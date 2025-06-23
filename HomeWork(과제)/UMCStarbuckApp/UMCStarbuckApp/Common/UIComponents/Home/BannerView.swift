//
//  BannerView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

// 배너 이미지를 보여주는 뷰
struct BannerView: View {
    
    // MARK: - Property
    /// 표시할 이미지 리소스
    let image: ImageResource
    
    // MARK: - Body
    var body: some View {
        // 이미지 리소스를 화면에 맞게 표시
        Image(image)
            .resizable() // 이미지 크기 조정 가능하게 설정
            .aspectRatio(contentMode: .fit) // 비율 유지하며 이미지 전체를 보여줌
    }
}

// 프리뷰용 샘플 뷰
#Preview {
    BannerView(image: .americanoHot) // 샘플 이미지로 프리뷰
}
