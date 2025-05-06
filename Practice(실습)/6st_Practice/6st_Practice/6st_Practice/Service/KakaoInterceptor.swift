//
//  KakaoInterceptor.swift
//  6st_Practice
//
//  Created by Apple Coding machine on 5/4/25.
//

import Foundation
import Alamofire


class KakaoInterceptor: RequestInterceptor, @unchecked Sendable{
    private let kakaoAPIKey: String
    
    init(apiKey: String) {
        self.kakaoAPIKey = apiKey
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
        request.headers.add(.authorization("KakaoAK \(kakaoAPIKey)"))
        print(request.headers)
        
        completion(.success(request))
    }
}
