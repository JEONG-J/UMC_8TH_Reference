//
//  TokenProviding.swift
//  MoyaTest
//
//  Created by Apple Coding machine on 5/11/25.
//

import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}
