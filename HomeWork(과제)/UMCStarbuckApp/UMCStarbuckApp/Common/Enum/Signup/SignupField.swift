//
//  SignupField.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/18/25.
//

import Foundation
import SwiftUI

/// 회원가입 화면에서 사용하는 입력 필드들을 정의한 열거형
/// 각각의 필드는 FormFieldType 프로토콜을 채택하여 UI 구성에 필요한 속성을 제공
enum SignUpField: CaseIterable, FormFieldType, Hashable {
    
    /// 닉네임 입력 필드
    case nickname
    
    /// 이메일 입력 필드
    case email
    
    /// 비밀번호 입력 필드
    case password
    
    /// 필드에 표시될 레이블 또는 placeholder 텍스트
    var title: String {
        switch self {
        case .nickname:
            return "닉네임"
        case .email:
            return "이메일"
        case .password:
            return "비밀번호"
        }
    }
    
    /// placeholder에 적용할 폰트
    var placeholderFont: Font {
        return .mainTextRegular18
    }
    
    /// placeholder에 적용할 텍스트 색상
    var placeholderTextColor: Color {
        return Color.gray02
    }
    
    /// 비밀번호 입력 여부 (`SecureField`로 표시할지 여부)
    var isSecure: Bool {
        self == .password
    }
    
    /// 키보드 타입 설정 (예: 이메일 키보드, 기본 키보드 등)
    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        default:
            return .default
        }
    }
    
    /// 키보드의 리턴(Submit) 버튼 스타일 설정
    /// - `.next`: 다음 입력 필드로 이동
    /// - `.done`: 입력 완료
    var submitLabel: SubmitLabel {
        switch self {
        case .nickname, .email:
            return .next
        case .password:
            return .done
        }
    }
}
