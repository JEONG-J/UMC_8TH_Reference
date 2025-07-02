//
//  CapsuleWidthMode.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/27/25.
//

import Foundation

/// 캡슐(Capsule) 형태의 UI 컴포넌트 너비 설정 모드를 정의한 열거형입니다.
/// - `textWidth`: 텍스트 길이에 맞춰 캡슐 너비를 자동 조절
/// - `fullWidth`: 화면 또는 지정된 영역의 전체 너비를 사용
enum CapsuleWidthMode {
    
    /// 텍스트 내용에 따라 캡슐 너비가 유동적으로 결정됨
    case textWidth
    
    /// 부모 뷰 또는 레이아웃 전체 너비를 사용하여 캡슐을 표시함
    case fullWidth
}
