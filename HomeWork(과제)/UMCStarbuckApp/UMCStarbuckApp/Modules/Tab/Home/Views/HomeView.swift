//
//  HomeView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Property
    @State var viewModel: HomeViewModel
    
    // MARK: - Constants
    fileprivate enum HomeConstants {
        static let mainSpacing: CGFloat = 20
        
        static let topImageHeight: CGFloat = 259
        static let topContetnsVStackHeight: CGFloat = 140
        static let topContentsOffst: CGFloat = 33
        
        static let topLeadingPadding: CGFloat = 28
        static let topTrailingPadding: CGFloat = 23
        static let goRihtSpacing: CGFloat = 4
        static let topTextLineSpacing: CGFloat = 3.6
        
        static let scrollBottomPadding: CGFloat = 100
        static let horizonPadding: CGFloat = 10
        
        static let topImageText: String = "골든 미모사 그린 티와 함께 \n행복한 새해의 축배를 들어요!"
        static let goRightText: String = "내용 보기"
    }
    
    // MARK: - Init
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    var body: some View {
        ScrollView(.vertical, content: {
            LazyVStack(spacing: HomeConstants.mainSpacing, content: {
                topContents
                middleContents
            })
        })
        .ignoresSafeArea()
        .contentMargins(.bottom, HomeConstants.scrollBottomPadding)
    }
    
    // MARK: - TopContents
    private var topContents: some View {
        ZStack(alignment: .bottom, content: {
            topImage
            imageAboveContents
        })
    }
    
    private var imageAboveContents: some View {
        VStack(alignment: .leading, spacing: .zero, content: {
            topText
            Spacer()
            goRightButton
            RewardProgressView()
        })
        .frame(height: HomeConstants.topContetnsVStackHeight)
        .offset(y: HomeConstants.topContentsOffst)
        .safeAreaPadding(.leading, HomeConstants.topLeadingPadding)
        .safeAreaPadding(.trailing, HomeConstants.topTrailingPadding)
    }
    
    private var topImage: some View {
        Image(.homeTop)
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: HomeConstants.topImageHeight)
            .ignoresSafeArea()
    }
    
    private var topText: some View {
        Text(HomeConstants.topImageText)
            .font(.mainTextBold24)
            .foregroundStyle(Color.black03)
            .lineLimit(nil)
            .lineSpacing(HomeConstants.topTextLineSpacing)
    }
    
    private var goRightButton: some View {
        HStack(spacing: HomeConstants.goRihtSpacing, content: {
            Spacer()
            
            Text(HomeConstants.goRightText)
                .font(.mainTextRegular13)
                .foregroundStyle(Color.gray06)
            
            Image(.goRight)
        })
    }
    
    // MARK: - MiddleContents
    @ViewBuilder
    private var middleContents: some View {
        Group {
            ForEach(viewModel.mergedContents) { item in
                switch item {
                case .banner(let banner):
                    BannerView(image: banner.image)
                case .section(let section):
                    rednerSection(section)
                }
            }
        }
        .offset(y: HomeConstants.topContentsOffst)
        .safeAreaPadding(.horizontal, HomeConstants.horizonPadding)
    }
    
    @ViewBuilder
    private func rednerSection(_ section: HomeSection) -> some View {
        switch section.contentType {
        case .coffee:
            if let coffees = section.items as? [CoffeeSummaryItem] {
                MenuView(title: section.title, items: coffees)
            }
        case .whatsNew:
            if let whatNew = section.items as? [WhatsNewItems] {
                WhatsNewView(title: section.title, items: whatNew)
            }
        case .dessert:
            if let bread = section.items as? [BreadMenuItems] {
                MenuView(title: section.title, items: bread)
            }
        }
    }
}

#Preview {
    HomeView(container: DIContainer())
}
