//
//  MapfloowMode.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/26/25.
//

import Foundation

/// 지도에서 사용자 위치를 추적하는 모드를 나타내는 열거형입니다.
/// 지도 카메라의 동작 방식을 정의하며, 사용자의 현재 위치와 방향을 따라가는지 여부를 제어합니다.
enum MapFollowMode {
    
    /// 사용자의 위치를 추적하지 않음
    case none
    
    /// 사용자의 현재 위치를 따라감 (지도 중심을 위치로 이동)
    case follow
    
    /// 사용자의 현재 위치와 방향(헤딩)을 모두 따라감
    /// 나침반 모드처럼 사용자의 진행 방향에 맞춰 지도 회전
    case followWithHeading
}
