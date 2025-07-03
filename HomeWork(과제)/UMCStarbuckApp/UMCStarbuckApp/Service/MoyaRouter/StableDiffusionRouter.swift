//
//  StableDiffusion.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/3/25.
//

import Foundation
import Moya

enum StableDiffusionRouter {
    case postTextImage(imageData: Txt2ImgRequest)
    case getProgress(skip: Bool)
}

extension StableDiffusionRouter: TargetType {
    var baseURL: URL {
        return URL(string: "http://127.0.0.1:7860")!
    }
    
    var path: String {
        switch self {
        case .postTextImage:
            return "/sdapi/v1/txt2img"
        case .getProgress:
            return "/sdapi/v1/progress"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postTextImage:
            return .post
        case .getProgress:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .postTextImage(let imageData):
            return .requestJSONEncodable(imageData)
        case .getProgress(let skip):
            return .requestParameters(parameters: [
                "skip_current_image": skip
            ], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
