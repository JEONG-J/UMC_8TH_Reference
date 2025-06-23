//
//  SignUpView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import SwiftUI

import SwiftUI

/// 회원가입 화면 View
/// 이메일, 닉네임, 비밀번호를 입력받아 키체인에 저장하고 이전 화면으로 돌아감
struct SignUpView: View {
    
    // MARK: - Property

    /// 회원가입 정보를 관리하는 ViewModel
    @State var viewModel: SignUpViewModel

    /// 현재 포커싱된 입력 필드 상태
    @FocusState private var focus: SignUpField?

    /// DIContainer: 앱 전역 의존성 (네비게이션, 서비스 등)
    @EnvironmentObject var container: DIContainer
    
    // MARK: - Constants

    /// UI 상수 정의 (간격, 타이틀 등)
    fileprivate enum SignUpConstants {
        static let topPadding: CGFloat = 110
        static let mainButtonHeight: CGFloat = 58
        static let topVStackSpacing: CGFloat = 28
        static let bottomPadding: CGFloat = 10
        static let signUpButtonTitle: String = "생성하기"
        static let topNavigationTitle: String = "가입하기"
    }
    
    // MARK: - Init

    /// 기본 생성자: 내부에서 ViewModel 인스턴스 생성
    init() {
        self.viewModel = .init()
    }
    
    // MARK: - Body

    var body: some View {
        VStack {
            topContetns         // 입력 필드 영역
            Spacer()
            bottomContents      // 생성 버튼 영역
        }
        .customNavigation(title: SignUpConstants.topNavigationTitle, leadingAction: {
            container.navigationRouter.pop() // 상단 뒤로가기 버튼 액션
        })
        .padding(.horizontal, UIConstants.defaultHorizontalPadding)
        .safeAreaPadding(.top, SignUpConstants.topPadding)
        .safeAreaPadding(.bottom, SignUpConstants.bottomPadding)
        .navigationBarBackButtonHidden(true) // 기본 백 버튼 숨김
    }
    
    // MARK: - TopContents (입력 필드 그룹)

    /// 이메일, 닉네임, 비밀번호 입력을 위한 필드
    private var topContetns: some View {
        VStack(spacing: SignUpConstants.topVStackSpacing, content: {
            FormTextField(fieldType: SignUpField.email, focusedField: $focus, currentField: .email, text: $viewModel.email)
            FormTextField(fieldType: SignUpField.nickname, focusedField: $focus, currentField: .nickname, text: $viewModel.nickname)
            FormTextField(fieldType: SignUpField.password, focusedField: $focus, currentField: .password, text: $viewModel.password)
        })
    }
    
    // MARK: - BottomContents (회원가입 버튼)

    /// 입력 완료 후 회원가입 처리 및 이전 화면으로 이동
    private var bottomContents: some View {
        MainButton(color: Color.green01, text: SignUpConstants.signUpButtonTitle, height: SignUpConstants.mainButtonHeight, action: {
            Task {
                await viewModel.saveKeychain()           // 키체인에 사용자 정보 저장
                container.navigationRouter.pop()         // 회원가입 완료 후 이전 화면으로 돌아감
            }
        })
    }
}

#Preview {
    SignUpView()
}
