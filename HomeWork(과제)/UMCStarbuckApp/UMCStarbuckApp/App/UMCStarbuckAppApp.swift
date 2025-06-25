//
//  UMCStarbuckAppApp.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import SwiftData

@main
struct UMCStarbuckAppApp: App {
    @StateObject var appFlowViewModel: AppFlowViewModel = .init()
    @StateObject var container: DIContainer = .init()
    
//    init() {
//        KakaoSDK.initSDK(appKey: Config.kakaoKey)
//    }
    
    var body: some Scene {
        WindowGroup {
            StoreSelectSheetView()
//            switch appFlowViewModel.appState {
//            case .splash:
//                SplashView()
//            case .login:
//                LoginView(container: container, appFlowViewModel: appFlowViewModel)
//            case .tab:
//                Text("!1")
//            }
        }
        .environmentObject(container)
        .environmentObject(appFlowViewModel)
        .modelContainer(for: ReceiptModel.self)
    }
}
