//
//  UserKeychain.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import Foundation

/// 유저 키체인 정보 Model
struct UserKeychain: Codable {
    var userId: String
    var userPassword: String
}
