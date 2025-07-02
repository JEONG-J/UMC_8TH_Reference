//
//  PayCardFieldType.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/1/25.
//

import Foundation
import SwiftUI

/// 결제 카드 입력 화면에서 사용되는 텍스트 필드 타입을 정의한 열거형입니다.
/// - `name`: 카드명 입력 필드 (텍스트)
/// - `number`: 카드 번호 입력 필드 (숫자)
///
/// 각 필드에 따라 플레이스홀더 문구, 키보드 타입, submitLabel(다음/완료)을 지정합니다.
enum PayCardFieldType {
    
    /// 카드명 입력 필드
    case name
    
    /// 카드 번호 입력 필드
    case number
    
    /// 각 필드에 맞는 플레이스홀더 문자열을 반환합니다.
    /// UI에서 사용자에게 입력 내용을 안내하는 데 사용됩니다.
    var placeholder: String {
        switch self {
        case .name:
            return "카드명 최대 20자"
        case .number:
            return "카드 번호 12자 입력"
        }
    }
    
    /// 키보드 하단의 제출 버튼 형태를 지정합니다.
    /// - 이름 입력은 `.next`, 번호 입력은 `.done` 으로 처리
    var submitLabel: SubmitLabel {
        switch self {
        case .name:
            return .next
        case .number:
            return .done
        }
    }
    
    /// 각 입력 필드에 적합한 키보드 타입을 지정합니다.
    /// - 카드명은 일반 키보드
    /// - 카드번호는 숫자 키패드
    var keyboardType: UIKeyboardType {
        switch self {
        case .name:
            return .default
        case .number:
            return .numberPad
        }
    }
}
