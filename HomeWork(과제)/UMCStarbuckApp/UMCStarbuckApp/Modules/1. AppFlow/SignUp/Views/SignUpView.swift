//
//  SignUpView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import SwiftUI

struct SignUpView: View {
    
    // MARK: - Property
    @State var viewModel: SignUpViewModel
    @FocusState private var focus: SignUpField?
    @EnvironmentObject var container: DIContainer
    
    // MARK: - Constants
    fileprivate enum SignUpConstants {
        static let topPadding: CGFloat = 110
        static let bottomPadding: CGFloat = 10
        static let topVStackSpacing: CGFloat = 28
        static let signUpButtonTitle: String = "생성하기"
        static let topNavigationTitle: String = "가입하기"
    }
    
    // MARK: - Init
    init() {
        self.viewModel = .init()
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            topContetns
            Spacer()
            bottomContents
        }
        .customNavigation(title: SignUpConstants.topNavigationTitle, action: {
            container.navigationRouter.pop()
        })
        .padding(.horizontal, UIConstants.defaultHorizontalPadding)
        .safeAreaPadding(.top, SignUpConstants.topPadding)
        .safeAreaPadding(.bottom, SignUpConstants.bottomPadding)
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - TopContents
    private var topContetns: some View {
        VStack(spacing: SignUpConstants.topVStackSpacing, content: {
            FormTextField(fieldType: SignUpField.email, focusedField: $focus, currentField: .email, text: $viewModel.email)
            FormTextField(fieldType: SignUpField.nickname, focusedField: $focus, currentField: .nickname, text: $viewModel.nickname)
            FormTextField(fieldType: SignUpField.password, focusedField: $focus, currentField: .password, text: $viewModel.password)
        })
    }
    
    // MARK: - BottomContents
    private var bottomContents: some View {
        MainButton(color: Color.green01, text: SignUpConstants.signUpButtonTitle, action: {
            Task {
                await viewModel.saveKeychain()
                container.navigationRouter.pop()
            }
        })
    }
}

#Preview {
    SignUpView()
}
