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
    /// 앱 흐름 상태 뷰모델
    @StateObject var appFlowViewModel: AppFlowViewModel = .init()
    /// DIContainer 의존성 주입
    @StateObject var container: DIContainer = .init()
    
    init() {
        KakaoSDK.initSDK(appKey: Config.kakaoKey)
    }
    
    var body: some Scene {
        WindowGroup {
            switch appFlowViewModel.appState {
            case .splash:
                SplashView()
                
            case .login:
                LoginView(container: container, appFlowViewModel: appFlowViewModel)
                // FIXME: - 카카오 SDK 사용 시 필수!!
                /* 카카오톡 로그인 시 앱으로 여는 경우와 웹으로 여는 경우가 존재합니다. 앱으로 여는 경우 다시 원래 앱으로 돌아오기 위해 앱 경로를 알 수 있게 해줘야합니다!!*/
                    .onOpenURL(perform: { url in
                        if (AuthApi.isKakaoTalkLoginUrl(url)) {
                            _ = AuthController.handleOpenUrl(url: url)
                        }
                    })
                
            case .tab:
                StarbucksTabView()
            }
        }
        .environmentObject(container)
        .environmentObject(appFlowViewModel)
        .modelContainer(for: [ReceiptModel.self, PayCardInfo.self])
    }
}
