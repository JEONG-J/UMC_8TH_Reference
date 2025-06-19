//
//  KakaoDTO.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation

protocol KakaoDTO {
    var accessToken: String { get }
    var nickname: String { get }
}

struct KakaoUser: KakaoDTO {
    var nickname: String
    var accessToken: String
}
