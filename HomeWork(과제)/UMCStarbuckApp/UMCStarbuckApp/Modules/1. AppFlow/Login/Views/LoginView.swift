//
//  LoginView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Property
    @State var viewModel: LoginViewModel
    @FocusState private var focus: LoginFieldType?
    
    // MARK: - Constants
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
                topContetns
                Spacer()
                middleContents
                Spacer()
                bottomContents
            })
            .padding(.horizontal, UIConstants.defaultHorizontalPadding)
            .safeAreaPadding(.bottom, UIConstants.defaultBottomPadding)
            .ignoresSafeArea(.keyboard)
            .task {
                UIApplication.shared.hideKeyboard()
            }
            .navigationDestination(for: NavigationDestination.self, destination: { destination in
                NavigationRoutingView(destination: destination)
                    .environmentObject(viewModel.container)
            })
        })
    }
    
    // MARK: - TopContetns
    private var topContetns: some View {
        VStack(alignment: .leading, spacing: LoginContetns.topMainContentsSpacing, content: {
            topLogoImage
            topTitleContetns
        })
    }
    
    private var topLogoImage: some View {
        Image(.logo)
            .resizable()
            .frame(width: LoginContetns.logoWidth, height: LoginContetns.logoHeight)
    }
    
    @ViewBuilder
    private var topTitleContetns: some View {
        VStack(alignment: .leading, spacing: LoginContetns.topTitleSpacing, content: {
            ForEach(LoginTitleText.allCases, id: \.self) { title in
                Text(title.rawValue)
                    .font(title.font)
                    .foregroundStyle(title.fontColor)
            }
        })
    }
    
    // MARK: - MiddleContents
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
    
    // MARK: - BottomContents
    private var bottomContents: some View {
        VStack(alignment: .center, spacing: LoginContetns.bottomVStackSpacing, content: {
            appSignUpButtn
            socialLoginButtons
        })
    }
    
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
    
    @ViewBuilder
    private var socialLoginButtons: some View {
        let items: [SocialLoginItem] = [
            .init(type: .kakao, action: {
                Task {
                    await viewModel.kakaoLogin()
                }
            }),
            .init(type: .apple, action: {
                // 애플 로그인 기능 구현 없음
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
