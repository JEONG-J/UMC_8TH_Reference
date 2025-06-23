//
//  OtherView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import SwiftUI

struct OtherView: View {
    
    // MARK: - Property
    @State var viewModel: OtherViewModel
    @EnvironmentObject var container: DIContainer
    
    fileprivate enum OtherConstants {
        static let diverOpacity: Double = 0.1
        static let payDiverPadding: CGFloat = 16
        
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
            Color.white01.ignoresSafeArea()
            
            VStack(spacing: OtherConstants.allContentsSpacing, content: {
                TopStatusBar()
                contents
            })
            .ignoresSafeArea()
        })
    }
    
    private var contents: some View {
        VStack(spacing: OtherConstants.allContentsSpacing, content: {
            topContents
            payContents
            supportContents
        })
        .background(Color.white01)
        .safeAreaPadding(.horizontal, OtherConstants.safeAreaHorizonPadding)
    }
    
    // MARK: - TopContents
    private var topContents: some View {
        VStack(spacing: OtherConstants.topVStackSpacing, content: {
            topTitle
            topControlButtons
        })
    }
    
    @ViewBuilder
    private var topTitle: some View {
        VStack(spacing: OtherConstants.topTextSpacing, content: {
            titleFirstLine
            titleSecondLine
        })
        .font(.mainTextSemiBold24)
    }
    
    private var titleFirstLine: some View {
        HStack(spacing: .zero, content: {
            Text("\(viewModel.loadNickname())")
                .foregroundStyle(Color.green01)
            
            Text(OtherConstants.userPostText)
                .foregroundStyle(Color.black)
        })
    }
    
    private var titleSecondLine: some View {
        HStack(spacing: OtherConstants.topTextEmojiSpacing, content: {
            Text(OtherConstants.welcomeText)
                .foregroundStyle(Color.black)

            Image(.welcomeEmoji)
        })
    }
    
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
    
    private var payContents: some View {
        VStack(spacing: .zero, content: {
            MenuSelectionCard(title: OtherConstants.payText, items: PayType.allCases) { selected in
                print(selected)
            }
            Divider()
                .background(Color.black.opacity(OtherConstants.diverOpacity))
                .padding(.top, OtherConstants.payDiverPadding)
        })
    }
    
    private var supportContents: some View {
        MenuSelectionCard(title: OtherConstants.support, items: SupportType.allCases) { selected in
            print(selected)
        }
    }
}

extension OtherView {
    private func topControlAction(_ selection: TopControlType) {
        switch selection {
        case .receipt:
            container.navigationRouter.push(to: .receiptView)
        default:
            break
        }
    }
}

#Preview {
    OtherView()
}
