//
//  OtherViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import Foundation

@Observable
class OtherViewModel {
    var keychainManager: KeychainManager = .standard
    
    // MARK: - Method
    public func loadNickname() -> String {
        let user = keychainManager.loadSession(for: "UMCStarbuckApp")
        return user?.userName ?? "(작성한 닉네임)"
    }
}
