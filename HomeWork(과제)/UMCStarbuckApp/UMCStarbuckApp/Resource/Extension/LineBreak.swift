//
//  LineBreak.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import Foundation
import SwiftUI

// String 타입에 커스텀 줄바꿈 처리를 위한 기능을 확장
extension String {
    /// 문자열의 모든 글자 사이에 유니코드 zero-width space(\u{200B})를 삽입하는 함수
    ///
    /// - Returns: 각 문자 사이에 `\u{200B}` 문자가 삽입된 새로운 문자열
    func customLineBreak() -> String {
        // 문자열을 문자 단위로 분리한 후, 각 문자 사이에 \u{200B}를 삽입하여 다시 합침
        return self.split(separator: "").joined(separator: "\u{200B}")
    }
}
