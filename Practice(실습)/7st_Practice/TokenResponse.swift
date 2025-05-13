//
//  TokenResponse.swift
//  MoyaTest
//
//  Created by Apple Coding machine on 5/11/25.
//

import Foundation

struct TokenResponse: Codable {
    var accessToken: String
    var refreshToken: String
}
