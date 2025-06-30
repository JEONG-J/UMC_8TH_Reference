//
//  FindStoreView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/27/25.
//

import SwiftUI

struct FindStoreView: View {
    
    // MARK: - Property
    @State var viewModel: FindStoreViewModel
    @EnvironmentObject var container: DIContainer
    
    // MARK: - Constats
    fileprivate enum FindStoreConstants {
        static let vStackSpacing: CGFloat = 17
        static let naviHorizonPadding: CGFloat = 32
        static let topBackgroundHeight: CGFloat = 104
        static let naviTitle: String = "매장 찾기"
        static let topContentsZindex: Double = 1
    }
    
    // MARK: - Init
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top, content: {
            topContentsOverlay
            middleContents
        })
        .toolbar(.hidden, for: .automatic) // Stack을 통해 지도로 들어오면 무조건 툴바 삭제 처리 필요해요! 그래서 커스텀 네비게이션을 모디피어가 아닌 뷰로 생성해야합니다!
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - TopContents
    private var topContentsOverlay: some View {
        VStack(spacing: FindStoreConstants.vStackSpacing, content: {
            topNavigation
            CustomSegment<FindStoreSegment, BrownSegmentStyle>(selectedSegment: $viewModel.findStoreSegment, style: BrownSegmentStyle())
        })
        .zIndex(FindStoreConstants.topContentsZindex)
    }
    
    private var topNavigation: some View {
        ZStack {
            Text(FindStoreConstants.naviTitle)
                .font(.mainTextMedium16)
                .foregroundStyle(Color.black)
            
            HStack {
                Button(action: {
                    container.navigationRouter.pop()
                }, label: {
                    Image(.leftChevron)
                })
                
                Spacer()
            }
            .padding(.horizontal, FindStoreConstants.naviHorizonPadding)
        }
    }
    
    // MARK: - MiddleContents
    private var middleContents: some View {
        VStack(spacing: .zero, content: {
            Rectangle()
                .fill(Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: FindStoreConstants.topBackgroundHeight)
                .findStoreShadow()
            
            viewBranching
        })
        .zIndex(.zero)
    }
    
    @ViewBuilder
    private var viewBranching: some View {
        switch viewModel.findStoreSegment {
        case .findStore:
            MapView(container: container)
        case .findeRoad:
            SearchRoadView(viewModel: viewModel)
        }
    }
}

#Preview {
    FindStoreView(container: DIContainer())
        .environmentObject(DIContainer())
}
