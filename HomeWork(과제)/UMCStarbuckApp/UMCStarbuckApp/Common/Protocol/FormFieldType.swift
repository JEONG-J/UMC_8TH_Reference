//
//  FormFieldType.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/18/25.
//

import Foundation
import SwiftUI

/// 입력 필드(TextField, SecureField 등)에 필요한 UI 속성들을 정의하는 프로토콜
/// 로그인, 회원가입 등 다양한 화면의 입력 필드를 공통된 방식으로 관리하기 위해 사용
protocol FormFieldType {
    
    /// 입력 필드의 제목 또는 레이블 텍스트
    /// 예: "아이디", "비밀번호", "이메일"
    var title: String { get }
    
    /// SecureField 사용 여부
    /// - true일 경우 비밀번호처럼 입력값이 숨겨짐
    var isSecure: Bool { get }
    
    /// 필드에 사용할 키보드 타입
    /// 예: .default, .emailAddress, .numberPad 등
    var keyboardType: UIKeyboardType { get }
    
    /// 키보드의 리턴 버튼 타입
    /// 예: .next, .done, .go 등
    var submitLabel: SubmitLabel { get }
    
    /// placeholder 텍스트에 사용할 폰트
    var placeholderFont: Font { get }
    
    /// placeholder 텍스트에 사용할 색상
    var placeholderTextColor: Color { get }
}
