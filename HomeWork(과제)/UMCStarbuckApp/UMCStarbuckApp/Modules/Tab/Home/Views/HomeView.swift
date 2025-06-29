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
        static let topTextLineSpacing: CGFloat = 3.6
                
        static let goRihtSpacing: CGFloat = 4
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
        .contentMargins(.bottom, UIConstants.defaultscrollBottomPadding)
        .background(Color.white)
    }
    
    // MARK: - TopContents
    /// 상단 컨텐츠
    private var topContents: some View {
        ZStack(alignment: .bottom, content: {
            topImage
            imageAboveContents
        })
    }
    
    // 상단 이미지 위에 올라가는 텍스트 및 버튼
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
    
    // 상단 배너 이미지
    private var topImage: some View {
        Image(.homeTop)
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: HomeConstants.topImageHeight)
            .ignoresSafeArea()
    }
    
    // 상단 배너에 표시될 텍스트
    private var topText: some View {
        Text(HomeConstants.topImageText)
            .font(.mainTextBold24)
            .foregroundStyle(Color.black03)
            .lineLimit(nil)
            .lineSpacing(HomeConstants.topTextLineSpacing)
    }
    
    // "내용 보기" 버튼
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
    /// 중간 컨텐츠
    @ViewBuilder
    private var middleContents: some View {
        Group {
            ForEach(viewModel.mergedContents) { item in
                switch item {
                case .banner(let banner):
                    BannerView(image: banner.image)
                case .section(let section):
                    renderSection(section)
                }
            }
        }
        .offset(y: HomeConstants.topContentsOffst)
        .safeAreaPadding(.horizontal, HomeConstants.horizonPadding)
    }
    
    // 섹션별 렌더링 처리
    @ViewBuilder
    private func renderSection(_ section: HomeSection) -> some View {
        switch section.contentType {
        case .coffee:
            if let coffees = section.items as? [CoffeeSummaryItem] {
                MenuView(title: section.title, items: coffees) { summary in
                    guard CoffeeDataSource.detailItems.contains(where: { $0.id == summary.id }) else {
                        print("상세 커피 정보 없음: \(summary.name)")
                        return
                    }
                    viewModel.container.navigationRouter.push(to: .coffeeDetail(id: summary.id))
                }
            }
            
        case .whatsNew:
            if let whatNew = section.items as? [WhatsNewItems] {
                WhatsNewView(title: section.title, items: whatNew)
            }
            
        case .dessert:
            if let bread = section.items as? [BreadMenuItems] {
                MenuView(title: section.title, items: bread) { _ in }
            }
        }
    }
}

#Preview {
    HomeView(container: DIContainer())
}
