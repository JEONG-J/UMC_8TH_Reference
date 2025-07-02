//
//  Config.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation

/// 앱의 Info.plist에서 API 키 등 설정 값을 가져오기 위한 설정 구조체입니다.
enum Config {
    
    /// Info.plist의 딕셔너리 데이터를 저장하는 정적 프로퍼티입니다.
    /// 앱 번들의 Info.plist를 읽어와 `[String: Any]` 형식으로 저장합니다.
    /// 실패 시 앱이 실행되지 않도록 `fatalError`를 발생시킵니다.
    private static let infoDicionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist 존재하지 않아요")  // Info.plist가 존재하지 않을 경우 치명적 오류 발생
        }
        return dict
    }()
    
    /// 카카오 API 키를 Info.plist에서 불러오는 정적 상수입니다.
    /// 키가 없으면 앱 실행 중단(`fatalError`)됩니다.
    static let kakaoKey: String = {
        guard let kakao = Config.infoDicionary["KAKAO_API"] as? String else {
            fatalError("카카오키 찾을 수 없어요")  // 키를 찾지 못할 경우 치명적 오류 발생
        }
        return kakao
    }()
}
