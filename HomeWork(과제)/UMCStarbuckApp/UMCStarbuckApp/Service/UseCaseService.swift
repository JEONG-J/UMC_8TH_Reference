//
//  UseCaseService.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation

/// API 서비스 모델
class UseCaseService {
    
    let kakaoManager: KakakoLoginManager
    let googleService: GooglePlaceService
    let kakaoService: KakaoService
    let osrmService: OSRMService
    let stableDiffusionService: StableDiffusionService
    
    init() {
        self.kakaoManager = .init()
        self.googleService = .init()
        self.kakaoService = .init()
        self.osrmService = .init()
        self.stableDiffusionService = .init()
    }
}
