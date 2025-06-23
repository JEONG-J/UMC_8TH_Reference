//
//  ConfirmDialog.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import SwiftUI

enum ConfirmDialogType: Identifiable, CaseIterable {
    case photoLibray
    case camera
    case cancel
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .photoLibray:
            return "앨범에서 가져오기"
        case .camera:
            return "카메라로 촬영하기"
        case .cancel:
            return "취소"
        }
    }
    
    var role: ButtonRole? {
        switch self {
        case .cancel:
            return .cancel
        default:
            return nil
        }
    }
}
