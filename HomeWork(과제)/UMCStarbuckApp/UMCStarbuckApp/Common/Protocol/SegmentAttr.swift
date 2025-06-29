//
//  SegmentProtocol.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import Foundation
import SwiftUI

protocol SegmentAttr: CaseIterable, Hashable {
    var segmentTitle: String { get }
    var segmentFont: Font { get }
}
