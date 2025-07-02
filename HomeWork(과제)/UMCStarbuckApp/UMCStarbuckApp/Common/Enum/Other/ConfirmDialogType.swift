//
//  ConfirmDialog.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import SwiftUI

/// 사진을 선택할 때 사용하는 확인 다이얼로그의 항목을 정의한 열거형입니다.
/// - `photoLibray`: 앨범에서 사진 선택
/// - `camera`: 카메라로 사진 촬영
/// - `cancel`: 작업 취소
///
/// `Identifiable`을 채택하여 SwiftUI 뷰에서 각 항목을 고유하게 식별할 수 있으며,
/// `CaseIterable`을 채택하여 모든 항목을 배열처럼 순회할 수 있습니다.
enum ConfirmDialogType: Identifiable, CaseIterable {
    
    /// 앨범에서 사진 선택
    case photoLibray
    
    /// 카메라로 사진 촬영
    case camera
    
    /// 취소 버튼
    case cancel
    
    /// `Identifiable` 프로토콜을 위한 고유 ID
    /// 각 항목 자체를 ID로 사용합니다.
    var id: Self { self }
    
    /// 다이얼로그에서 보여줄 텍스트 제목
    var title: String {
        switch self {
        case .photoLibray:
            return "앨범에서 가져오기"
        case .camera:
            return "카메라로 촬영하기"
        case .cancel:
            return "취소"
        }
    }
    
    /// 버튼 역할을 지정합니다.
    /// `cancel` 항목은 취소 역할로 설정되어 버튼이 별도 스타일로 표시됩니다.
    var role: ButtonRole? {
        switch self {
        case .cancel:
            return .cancel
        default:
            return nil
        }
    }
}
