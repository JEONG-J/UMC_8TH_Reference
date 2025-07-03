//
//  Base64.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/3/25.
//

import UIKit

extension String {
    
    /// Base64 인코딩된 문자열을 UIImage로 변환합니다.
    ///
    /// 이 메서드는 data URI scheme (`data:image/png;base64,...`) 형태의 문자열도 처리할 수 있습니다.
    /// - Returns: 디코딩된 UIImage 또는 실패 시 nil
    func toUIImageFromBase64() -> UIImage? {
        let cleanedBase64: String

        // Base64 문자열이 data URI 형식인 경우, 헤더 부분을 제거합니다.
        if self.starts(with: "data:image") {
            cleanedBase64 = self.replacingOccurrences(
                of: "^data:image/[^;]+;base64,",  // 정규식: 'data:image/...;base64,' 부분
                with: "",
                options: .regularExpression
            )
        } else {
            // 이미 순수한 base64 문자열인 경우 그대로 사용
            cleanedBase64 = self
        }

        // base64 문자열을 Data로 디코딩
        guard let data = Data(base64Encoded: cleanedBase64) else { return nil }
        
        // Data를 UIImage로 변환
        return UIImage(data: data)
    }
}
