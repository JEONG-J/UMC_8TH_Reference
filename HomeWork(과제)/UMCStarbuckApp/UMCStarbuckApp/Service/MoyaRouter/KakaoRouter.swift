//
//  KakaoRoute.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/2/25.
//

import Foundation
import Moya

enum KakaoRouter {
    case placeKeyword(query: String)
}

extension KakaoRouter: TargetType {
    var baseURL: URL {
        return URL(string: "https://dapi.kakao.com")!
    }
    
    var path: String {
        return "/v2/local/search/keyword"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .placeKeyword(let query):
            return .requestParameters(parameters: ["query": query], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "KakaoAK \(Config.KAKAO_RESTKEY)"
        ]
    }}
