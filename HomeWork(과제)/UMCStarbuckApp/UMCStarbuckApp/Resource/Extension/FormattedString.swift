//
//  Date.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import SwiftUI

extension Date {
    /// `Date` 객체를 "yyyy.MM.dd HH:mm" 형식의 문자열로 변환합니다.
    ///
    /// 예: 2025년 7월 3일 오후 5시 30분 → "2025.07.03 17:30"
    /// - Returns: 포맷된 날짜 문자열
    func formattedDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter.string(from: self)
    }
}

extension Int {
    /// 정수(Int)를 천 단위 쉼표(,)를 포함한 문자열로 변환합니다.
    ///
    /// 예: 1000000 → "1,000,000"
    /// - Returns: 포맷된 숫자 문자열
    func formattedWithComma() -> String {
        NumberFormatter.localizedString(from: NSNumber(value: self), number: .decimal)
    }
}
