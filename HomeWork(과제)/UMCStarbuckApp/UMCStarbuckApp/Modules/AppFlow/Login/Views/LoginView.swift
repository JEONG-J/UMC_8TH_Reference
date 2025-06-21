//
//  LoginView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import SwiftUI

/// 로그인 화면 View
/// 앱 자체 로그인 및 소셜 로그인(카카오, 애플) 기능을 제공하며
/// 입력 필드, 버튼, 로고 등의 UI 구성 포함
struct LoginView: View {
    
    // MARK: - Property

    /// 로그인 기능 및 상태를 관리하는 ViewModel
    @State var viewModel: LoginViewModel

    /// 현재 포커싱된 입력 필드를 관리하는 FocusState
    @FocusState private var focus: LoginFieldType?
    
    // MARK: - Constants

    /// 로그인 뷰에 사용되는 UI 간격 및 텍스트 상수 정의
    fileprivate enum LoginContetns {
        static let logoHeight: CGFloat = 95
        static let logoWidth: CGFloat = 97
        
        static let topTitleSpacing: CGFloat = 19
        static let topMainContentsSpacing: CGFloat = 28
        
        static let middleTextFieldGroupSpacing: CGFloat = 28
        static let middleVStackSpacing: CGFloat = 47
        static let middleContentsHeight: CGFloat = 180
        
        static let bottomVStackSpacing: CGFloat = 19
        
        static let loginButtonTitle: String = "로그인하기"
        static let bottomSignUpText: String = "이메일로 회원가입하기"
    }
    
    // MARK: - Init

    /// DIContainer와 앱 흐름 ViewModel(AppFlowViewModel)을 주입받아 초기화
    init(
        container: DIContainer,
        appFlowViewModel: AppFlowViewModel
    ) {
        self.viewModel = .init(container: container, appFlowViewModel: appFlowViewModel)
    }
    
    // MARK: - Body

    var body: some View {
        NavigationStack(path: $viewModel.container.navigationRouter.destination, root: {
            VStack(alignment: .leading, content: {
                Spacer()
                topContetns         // 로고와 타이틀
                Spacer()
                middleContents      // 텍스트필드와 로그인 버튼
                Spacer()
                bottomContents      // 회원가입 버튼 및 소셜 로그인
            })
            .padding(.horizontal, UIConstants.defaultHorizontalPadding)
            .safeAreaPadding(.bottom, UIConstants.defaultBottomPadding)
            .ignoresSafeArea(.keyboard)
            .task {
                UIApplication.shared.hideKeyboard() // 초기 진입 시 키보드 숨김
            }
            .navigationDestination(for: NavigationDestination.self, destination: { destination in
                NavigationRoutingView(destination: destination)
                    .environmentObject(viewModel.container)
            })
        })
    }
    
    // MARK: - Top Contents (로고 및 타이틀 영역)
    
    /// 상단 컨텐츠
    private var topContetns: some View {
        VStack(alignment: .leading, spacing: LoginContetns.topMainContentsSpacing, content: {
            topLogoImage
            topTitleContetns
        })
    }
    
    /// 상단 로고
    private var topLogoImage: some View {
        Image(.logo)
            .resizable()
            .frame(width: LoginContetns.logoWidth, height: LoginContetns.logoHeight)
    }
    
    /// 상단 타이틀 및 서브 타이틀
    private var topTitleContetns: some View {
        VStack(alignment: .leading, spacing: LoginContetns.topTitleSpacing, content: {
            ForEach(LoginTitleText.allCases, id: \.self) { title in
                Text(title.rawValue)
                    .font(title.font)
                    .foregroundStyle(title.fontColor)
            }
        })
    }
    
    // MARK: - Middle Contents (텍스트 필드 + 로그인 버튼)
    
    /// 중간 컨텐츠
    private var middleContents: some View {
        VStack(spacing: LoginContetns.middleVStackSpacing, content: {
            textFieldGroup

            MainButton(color: .green01, text: LoginContetns.loginButtonTitle, action: {
                Task {
                    await viewModel.actionLoginButtonTap()
                }
            })
        })
        .frame(height: LoginContetns.middleContentsHeight)
    }

    /// ID 및 비밀번호 입력 필드 그룹
    private var textFieldGroup: some View {
        VStack(spacing: LoginContetns.middleTextFieldGroupSpacing, content: {
            FormTextField(fieldType: LoginFieldType.id, focusedField: $focus, currentField: .id, text: $viewModel.id)
                .onSubmit {
                    focus = .password
                }
            
            FormTextField(fieldType: LoginFieldType.password, focusedField: $focus, currentField: .password, text: $viewModel.password)
                .onSubmit {
                    focus = nil
                }
        })
    }
    
    // MARK: - Bottom Contents (회원가입 + 소셜 로그인 버튼)
    
    /// 하단 컨텐츠
    private var bottomContents: some View {
        VStack(alignment: .center, spacing: LoginContetns.bottomVStackSpacing, content: {
            appSignUpButtn
            socialLoginButtons
        })
    }

    /// 이메일 회원가입 이동 버튼
    private var appSignUpButtn: some View {
        Button(action: {
            viewModel.container.navigationRouter.push(to: .signUp)
        }, label: {
            Text(LoginContetns.bottomSignUpText)
                .font(.mainTextRegular12)
                .foregroundStyle(Color.gray04)
                .underline(pattern: .solid)
                .frame(maxWidth: .infinity, alignment: .center)
        })
    }

    /// 카카오 및 애플 로그인 버튼
    @ViewBuilder
    private var socialLoginButtons: some View {
        let items: [SocialLoginItem] = [
            .init(type: .kakao, action: {
                Task {
                    await viewModel.kakaoLogin()
                }
            }),
            .init(type: .apple, action: {
                // 애플 로그인 기능 구현 예정
            })
        ]
        
        ForEach(items, id: \.id) { button in
            Button(action: {
                button.action()
            }, label: {
                button.type.image
            })
        }
    }
}
