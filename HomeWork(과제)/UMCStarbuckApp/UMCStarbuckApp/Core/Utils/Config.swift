//
//  Config.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation

enum Config {
    private static let infoDicionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist 존재하지 않아요")
        }
        return dict
    }()
    
    static let kakaoKey: String = {
        guard let kakao = Config.infoDicionary["KAKAO_API"] as? String else {
            fatalError("카카오키 찾을 수 없어요")
        }
        return kakao
    }()
}
