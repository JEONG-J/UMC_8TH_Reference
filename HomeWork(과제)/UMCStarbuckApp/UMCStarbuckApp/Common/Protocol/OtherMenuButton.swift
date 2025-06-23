//
//  OtherMenuButton.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import Foundation
import SwiftUI

protocol OtherMenuButton: Identifiable, CaseIterable, RawRepresentable where RawValue == String {
    var icon: ImageResource { get }
    var title: String { get }
}
