//
//  Font.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretendard {
        case extraBold
        case semibold
        case bold
        case regular
        case medium
        case light
        
        var value: String {
            switch self {
            case .extraBold:
                return "PretendardVariable-ExtraBold"
            case .semibold:
                return "PretendardVariable-SemiBold"
            case .bold:
                return "PretendardVariable-Bold"
            case .regular:
                return "PretendardVariable-Regular"
            case .medium:
                return "PretendardVariable-Medium"
            case .light:
                return "PretendardVariable-Light"
            }
        }
    }
    
    static func pretendard(type: Pretendard, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    // MARK: - Extra
    static var mainTextExtraBold: Font {
        return .pretendard(type: .extraBold, size: 24)
    }
    
    // MARK: - Bold
    static var mainTextBold24: Font {
        return .pretendard(type: .bold, size: 24)
    }
    
    static var mainTextBold22: Font {
        return .pretendard(type: .bold, size: 22)
    }
    
    static var mainTextBold20: Font {
        return .pretendard(type: .bold, size: 20)
    }
    
    static var mainTextBold16: Font {
        return .pretendard(type: .bold, size: 16)
    }
    
    // MARK: - SemiBold
    static var mainTextSemiBold38: Font {
        return .pretendard(type: .semibold, size: 38)
    }
    
    static var mainTextSemiBold24: Font {
        return .pretendard(type: .semibold, size: 24)
    }
    
    static var mainTextSemiBold22: Font {
        return .pretendard(type: .semibold, size: 22)
    }
    
    static var mainTextSemiBold18: Font {
        return .pretendard(type: .semibold, size: 18)
    }
    
    static var mainTextSemiBold16: Font {
        return .pretendard(type: .semibold, size: 16)
    }
    
    static var mainTextSemiBold14: Font {
        return .pretendard(type: .semibold, size: 14)
    }
    
    static var mainTextSemiBold13: Font {
        return .pretendard(type: .semibold, size: 13)
    }
    
    static var mainTextSemiBold12: Font {
        return .pretendard(type: .semibold, size: 12)
    }
    
    // MARK: - Regular
    
    static var mainTextRegular18: Font {
        return .pretendard(type: .regular, size: 18)
    }
    
    static var mainTextRegular13: Font {
        return .pretendard(type: .regular, size: 13)
    }
    
    static var mainTextRegular12: Font {
        return .pretendard(type: .regular, size: 12)
    }
    
    static var mainTextRegular09: Font {
        return .pretendard(type: .regular, size: 9)
    }
    
    // MARK: - Medium
    static var mainTextMedium18: Font {
        return .pretendard(type: .medium, size: 18)
    }
    
    static var mainTextMedium16: Font {
        return .pretendard(type: .medium, size: 16)
    }
    
    static var mainTextMedium13: Font {
        return .pretendard(type: .medium, size: 13)
    }
    
    static var mainTextMedium10: Font {
        return .pretendard(type: .medium, size: 10)
    }
    
    static var mainTextMedium08: Font {
        return .pretendard(type: .medium, size: 8)
    }
    
    // MARK: - Light
    static var mainTextLight14: Font {
        return .pretendard(type: .light, size: 14)
    }
    static var mainTextLight24: Font {
        return .pretendard(type: .light, size: 24)
    }
}
