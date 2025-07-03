//
//  OSRMRouter.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/2/25.
//

import Foundation
import Moya

enum OSRMRouter {
    case getRoute(route: OSRMRouteRequset)
}

extension OSRMRouter: TargetType {
    var baseURL: URL {
        return URL(string: "http://localhost:8080")!  /* local로 실행 주소 */
        
    }
    
    var path: String {
        switch self {
        case .getRoute(let route):
            return "/route/v1/foot/\(route.startPoint.lng),\(route.startPoint.lat);\(route.endPoint.lng),\(route.endPoint.lat)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getRoute:
            return .requestParameters(parameters: [
                "geometries": "geojson"
            ], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
