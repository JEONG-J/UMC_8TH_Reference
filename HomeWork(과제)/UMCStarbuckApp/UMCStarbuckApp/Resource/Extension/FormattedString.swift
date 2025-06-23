//
//  Date.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import SwiftUI

extension Date {
    func formattedDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter.string(from: self)
    }
}

extension Int {
    func formattedWithComma() -> String {
        NumberFormatter.localizedString(from: NSNumber(value: self), number: .decimal)
    }
}
