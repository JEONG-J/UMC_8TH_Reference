//
//  FindStoreView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/27/25.
//

import SwiftUI

/// 스타벅스 매장 찾기 화면
struct FindStoreView: View {
    
    // MARK: - Property
    /// 매장 찾기용 ViewModel (세그먼트 선택, 검색 상태 관리)
    @State var viewModel: FindStoreViewModel
    
    /// 의존성 주입 컨테이너 (네비게이션 라우터 등 포함)
    @EnvironmentObject var container: DIContainer
    
    // MARK: - Constats
    
    /// 뷰에 사용되는 레이아웃 및 텍스트 상수 정의
    fileprivate enum FindStoreConstants {
        static let vStackSpacing: CGFloat = 17
        static let prgoressHspacing: CGFloat = 8
        static let naviHorizonPadding: CGFloat = 32
        
        static let topBackgroundHeight: CGFloat = 104
        static let topContentsZindex: Double = 1
        
        static let naviTitle: String = "매장 찾기"
        static let progressText: String = "경로 검색 중.."
    }
    
    // MARK: - Init
    
    /// 외부에서 DIContainer를 받아 초기화
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .top, content: {
            topContentsOverlay     // 상단 네비게이션 및 세그먼트 뷰
            middleContents         // 세그먼트에 따라 바뀌는 메인 콘텐츠
        })
        // FIXME: - 지도를 사용하는데, 크기를 전체 스크린으로 사용하지 않을 경우 꼭 히든으로 해야합니다!
        .toolbar(.hidden, for: .automatic) // 내비게이션 바 제거 (지도 진입 시 필요)
        .navigationBarBackButtonHidden(true) // 기본 뒤로가기 버튼 숨김
        .customDetail(content: {
            if viewModel.isSearchLoading {
                progressView
            } else if viewModel.showSearchAlert {
                StoreSearchAlert(showAlert: $viewModel.showSearchAlert, position: viewModel.routePosition)
            }
        })
    }
    
    // MARK: - TopContents
    
    /// 상단 네비게이션 타이틀 + 세그먼트
    private var topContentsOverlay: some View {
        VStack(spacing: FindStoreConstants.vStackSpacing, content: {
            topNavigation
            CustomSegment<FindStoreSegment, BrownSegmentStyle>(
                selectedSegment: $viewModel.findStoreSegment,
                style: BrownSegmentStyle()
            )
        })
        .zIndex(FindStoreConstants.topContentsZindex) // ZIndex로 뷰 계층 제어
    }
    
    /// 상단 네비게이션 뷰 (뒤로가기 포함)
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
    
    /// 배경용 흰색 영역 + 실제 콘텐츠 뷰 분기
    private var middleContents: some View {
        VStack(spacing: .zero, content: {
            Rectangle()
                .fill(Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: FindStoreConstants.topBackgroundHeight)
                .findStoreShadow() // 그림자 적용 (커스텀 Modifier)
            
            viewBranching // 세그먼트에 따른 뷰 선택
        })
        .zIndex(.zero) // TopContents보다 아래로
    }
    
    /// 세그먼트에 따라 지도 뷰 또는 길찾기 뷰 보여주기
    @ViewBuilder
    private var viewBranching: some View {
        switch viewModel.findStoreSegment {
        case .findStore:
            MapView(container: container)
        case .findeRoad:
            SearchRoadView(viewModel: viewModel)
        }
    }
    
    // MARK: - Progress
    
    /// 로딩 인디케이터 (검색 중)
    private var progressView: some View {
        HStack(spacing: FindStoreConstants.prgoressHspacing, content: {
            ProgressView()
                .tint(Color.green00)
            Text(FindStoreConstants.progressText)
                .font(.mainTextMedium16)
                .foregroundStyle(Color.white)
        })
    }
}

#Preview {
    FindStoreView(container: DIContainer())
        .environmentObject(DIContainer())
}
