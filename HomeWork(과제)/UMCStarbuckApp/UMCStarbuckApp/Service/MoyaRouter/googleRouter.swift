//
//  googleRouter.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/2/25.
//

import Foundation
import Moya

enum GoogleRouter {
    case getGooglePlace(query: String)
}

extension GoogleRouter: TargetType {
    var baseURL: URL {
        return URL(string: "https://maps.googleapis.com")!
    }
    
    var path: String {
        return "/maps/api/place/textsearch/json"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getGooglePlace(let query):
            return .requestParameters(parameters: [
                "query": query,
                "key": Config.googleKey
            ], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
}
