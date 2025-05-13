//
//  AuthAPI.swift
//  MoyaTest
//
//  Created by Apple Coding machine on 5/11/25.
//
import Foundation
import Moya
import SwiftUI

enum AuthRouter {
    case sendRefreshToken(refreshToken: String) // 리프레시 토큰 갱신
    case login
}

extension AuthRouter: APITargetType {
    
    
    var path: String {
        switch self {
        case .sendRefreshToken:
            return "/auth/refresh"
        case .login:
            return "/auth/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendRefreshToken, .login:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .sendRefreshToken(let refreshToken):
            return .requestParameters(parameters: ["refreshToken": refreshToken], encoding: URLEncoding.queryString)
        case .login:
            return .requestPlain
        }
    }
}
