//
//  SocialLogin.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/18/25.
//

import Foundation
import SwiftUI

/// 소셜 로그인 타입을 정의하는 열거형 (카카오, 애플 로그인)
enum SocialLoginType: CaseIterable {
    case kakao   // 카카오 로그인
    case apple   // 애플 로그인

    /// 각 소셜 로그인 타입에 대응하는 이미지 리소스 반환
    var image: Image {
        switch self {
        case .kakao: return Image(.kakao)  // Assets.xcassets에 등록된 "kakao" 이미지 사용
        case .apple: return Image(.apple)  // Assets.xcassets에 등록된 "apple" 이미지 사용
        }
    }
}

/// 개별 소셜 로그인 버튼을 나타내는 모델 구조체
/// 뷰에서 ForEach 등으로 반복 사용 가능하게 Identifiable 채택
struct SocialLoginItem: Identifiable {
    var id: UUID = .init()             // 고유 식별자 (ForEach에서 사용)
    let type: SocialLoginType          // 로그인 타입 (카카오 또는 애플)
    let action: () -> Void             // 해당 로그인 버튼이 눌렸을 때 실행할 액션
}
