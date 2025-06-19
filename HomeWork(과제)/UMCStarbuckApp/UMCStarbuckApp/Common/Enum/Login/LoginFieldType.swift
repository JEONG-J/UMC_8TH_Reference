//
//  LoginFieldType.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/18/25.
//

import Foundation
import SwiftUI

/// 로그인 화면에서 사용할 입력 필드 타입을 정의한 enum
/// 각 케이스에 따라 placeholder, 키보드 타입, submitLabel 등의 속성을 지정함
enum LoginFieldType: CaseIterable, FormFieldType, Hashable {
    
    /// 아이디 입력 필드
    case id
    /// 비밀번호 입력 필드
    case password
    
    /// 필드 상단 또는 placeholder에 표시할 텍스트
    var title: String {
        switch self {
        case .id:
            return "아이디"
        case .password:
            return "비밀번호"
        }
    }
    
    /// placeholder에 적용할 폰트 스타일
    var placeholderFont: Font {
        return .mainTextRegular13
    }
    
    /// placeholder 텍스트 컬러
    var placeholderTextColor: Color {
        return Color.black01
    }
    
    /// 보안 입력 여부 (비밀번호일 경우 true)
    var isSecure: Bool {
        switch self {
        case .password:
            return true
        default:
            return false
        }
    }
    
    /// 해당 필드에 맞는 키보드 타입
    var keyboardType: UIKeyboardType {
        .default
    }
    
    /// 키보드 submit 버튼 스타일 설정
    /// - `.next`: 다음 필드로 이동
    /// - `.done`: 입력 완료
    var submitLabel: SubmitLabel {
        switch self {
        case .id:
            return .next
        case .password:
            return .done
        }
    }
}
