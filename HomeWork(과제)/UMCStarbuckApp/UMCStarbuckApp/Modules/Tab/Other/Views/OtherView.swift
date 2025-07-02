//
//  OtherView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import SwiftUI

/// 마이 페이지 또는 기타 탭에 해당하는 화면
struct OtherView: View {
    
    // MARK: - Property
    
    /// 뷰모델 상태 관리
    @State var viewModel: OtherViewModel
    
    /// 전역 종속성 주입 컨테이너 (네비게이션 등)
    @EnvironmentObject var container: DIContainer
    
    /// 내부에서 사용하는 상수 정의
    fileprivate enum OtherConstants {
        static let diverOpacity: Double = 0.1
        static let payDiverPadding: CGFloat = 16
        static let scrollBottomPadding: CGFloat = 50
        
        static let topVStackSpacing: CGFloat = 24
        static let topTextSpacing: CGFloat = 5
        static let topTextEmojiSpacing: CGFloat = 4
        static let topControlButtonSpacing: CGFloat = 10
        static let topControlButtonWidth: CGFloat = 327
        static let topControlButtonHeight: CGFloat = 108
        
        static let allContentsSpacing: CGFloat = 41
        static let safeAreaHorizonPadding: CGFloat = 10
        
        static let payText: String = "Pay"
        static let support: String = "고객 지원"
        static let welcomeText: String = "환영합니다!"
        static let userPostText: String = "님"
    }
    
    // MARK: - Init
    
    init() {
        self.viewModel = .init()
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .top, content: {
            // 배경 색상
            Color.white01.ignoresSafeArea()
            
            VStack(spacing: .zero, content: {
                TopStatusBar() // 상태바 영역
                contents        // 본문 콘텐츠
            })
            .ignoresSafeArea()
        })
    }
    
    /// 전체 콘텐츠 (스크롤 가능)
    private var contents: some View {
        ScrollView(.vertical, content: {
            VStack(spacing: OtherConstants.allContentsSpacing, content: {
                topContents
                payContents
                supportContents
            })
            .background(Color.white01)
            .safeAreaPadding(.horizontal, OtherConstants.safeAreaHorizonPadding)
            .padding(.bottom, UIConstants.defaultscrollBottomPadding)
        })
        .contentMargins(.top, OtherConstants.allContentsSpacing, for: .scrollContent)
    }
    
    // MARK: - TopContents
    
    /// 상단 환영 메시지 + 컨트롤 버튼
    private var topContents: some View {
        VStack(spacing: OtherConstants.topVStackSpacing, content: {
            topTitle
            topControlButtons
        })
    }
    
    /// 사용자 이름 + 환영 메시지
    @ViewBuilder
    private var topTitle: some View {
        VStack(spacing: OtherConstants.topTextSpacing, content: {
            titleFirstLine
            titleSecondLine
        })
        .font(.mainTextSemiBold24)
    }
    
    /// 첫 번째 줄 - 닉네임 + "님"
    private var titleFirstLine: some View {
        HStack(spacing: .zero, content: {
            Text("\(viewModel.loadNickname())")
                .foregroundStyle(Color.green01)
            
            Text(OtherConstants.userPostText)
                .foregroundStyle(Color.black)
        })
    }
    
    /// 두 번째 줄 - 환영 텍스트 + 이모지
    private var titleSecondLine: some View {
        HStack(spacing: OtherConstants.topTextEmojiSpacing, content: {
            Text(OtherConstants.welcomeText)
                .foregroundStyle(Color.black)
            
            Image(.welcomeEmoji)
        })
    }
    
    /// 영수증, 내정보 등 상단 제어 카드들
    private var topControlButtons: some View {
        HStack(spacing: OtherConstants.topControlButtonSpacing, content: {
            ForEach(TopControlType.allCases, id: \.id) { type in
                TopControlCard(type: type) { selection in
                    self.topControlAction(selection)
                }
            }
        })
        .frame(width: OtherConstants.topControlButtonWidth, height: OtherConstants.topControlButtonHeight)
    }
    
    // MARK: - MiddleContents
    
    /// Pay 관련 메뉴 영역
    private var payContents: some View {
        VStack(spacing: .zero, content: {
            MenuSelectionCard(title: OtherConstants.payText, items: PayType.allCases) { selected in
                print(selected) // 추후 액션 연결
            }
            Divider()
                .background(Color.black.opacity(OtherConstants.diverOpacity))
                .padding(.top, OtherConstants.payDiverPadding)
        })
    }
    
    /// 고객 지원 메뉴 영역
    private var supportContents: some View {
        MenuSelectionCard(title: OtherConstants.support, items: SupportType.allCases) { selected in
            supportContentsAction(selected)
        }
    }
}

// MARK: - Extension (Action 처리)

extension OtherView {
    
    /// 상단 카드 선택 시 액션
    private func topControlAction(_ selection: TopControlType) {
        switch selection {
        case .receipt:
            container.navigationRouter.push(to: .receiptView)
        default:
            break
        }
    }
    
    /// 고객지원 메뉴 선택 시 액션
    private func supportContentsAction(_ selection: SupportType) {
        switch selection {
        case .storeInfo:
            container.navigationRouter.push(to: .findStoreView)
        default:
            break
        }
    }
}

// MARK: - Preview

#Preview {
    OtherView()
}
