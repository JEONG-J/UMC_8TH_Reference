//
//  MoyaProvider+Concurrency.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/2/25.
//

import Foundation
import Moya

extension MoyaProvider {
    public func request(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
