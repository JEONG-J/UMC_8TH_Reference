//
//  StoreSelectSheetView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import SwiftUI

/// 사용자가 매장을 리스트 또는 지도 기반으로 선택할 수 있는 시트 형태의 View
struct StoreSelectSheetView: View {
    
    // MARK: - Property
    
    /// 매장 정보를 관리하는 ViewModel
    @State var viewModel: StoreSelectSheetViewModel
    
    /// 리스트와 지도 전환 상태를 나타냄
    @State private var isMapVisible: Bool = false
    
    /// DI를 위한 컨테이너 객체
    @EnvironmentObject var container: DIContainer
    
    // MARK: - Constants
    
    /// UI 구성에 사용되는 레이아웃 상수 모음
    fileprivate enum StoreSelectSheetConstants {
        static let textFieldTopPadding: CGFloat = 4
        static let textFieldLeadingPadding: CGFloat = 7
        static let textFieldBottomPadding: CGFloat = 3
        static let textFieldCornerRadius: CGFloat = 5
        static let textFieldHeight: CGFloat = 27
        
        static let topVstackHorizonPadding: CGFloat = 32
        static let topVstackTopPadding: CGFloat = 11
        static let topVstackSpacing: CGFloat = 24
        static let searchContentsSpacing: CGFloat = 23
        
        static let listTopSpacing: CGFloat = 28
        static let listSpacing: CGFloat = 16
        static let dividerPadding: CGFloat = 17
        
        static let capsuleWidth: CGFloat = 70
        static let capsuleHeight: CGFloat = 4
        
        static let naviTitle: String = "매장 설정"
        static let searchBarPlaceholder: String = "검색"
        static let emptyDataText: String = "스타벅스 정보를 가져올 수 없습니다...!"
    }
    
    // MARK: - Init
    
    /// 의존성 주입을 위한 초기화
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: .zero, content: {
            topContents              // 상단 콘텐츠(타이틀, 검색 등)
            middleContents           // 리스트 or 지도 콘텐츠
        })
        .safeAreaPadding(.top, StoreSelectSheetConstants.topVstackTopPadding)
        .task {
            await viewModel.getAllStores()   // 최초 진입 시 전체 매장 데이터 로드
            await viewModel.nearByStores()   // 근처 지역으로 매장 필터
        }
        .overlay(content: {
            // 로딩 상태일 때 프로그레스 표시
            if viewModel.isLoading {
                ProgressView()
                    .controlSize(.large)
                    .tint(Color.green02)
            }
        })
    }
    
    // MARK: - TopContents
    
    /// 상단 콘텐츠: 드래그 캡슐, 타이틀, 검색 영역
    private var topContents: some View {
        VStack(spacing: StoreSelectSheetConstants.topVstackSpacing, content: {
            topCapsule
            topNavigationBar
            searchContents
        })
        .safeAreaPadding(.horizontal, StoreSelectSheetConstants.topVstackHorizonPadding)
    }
    
    /// 상단 드래그 캡슐 (시트를 위로 드래그 가능하다는 시각적 표현)
    private var topCapsule: some View {
        Capsule()
            .fill(Color.gray04)
            .frame(width: StoreSelectSheetConstants.capsuleWidth, height: StoreSelectSheetConstants.capsuleHeight)
    }
    
    /// 네비게이션 타이틀 + 지도/리스트 전환 버튼
    private var topNavigationBar: some View {
        ZStack {
            navigationTitle
            convertListAndMap
        }
    }
    
    /// 검색 필드 및 검색 타입 선택 세그먼트
    private var searchContents: some View {
        VStack(alignment: .leading, spacing: StoreSelectSheetConstants.searchContentsSpacing, content: {
            topSearchBar
            StoreSearchSegment(storeSearchType: $viewModel.storeSearchType)
        })
    }
    
    /// 구분선
    private var divider: some View {
        Divider()
            .foregroundStyle(Color.gray07)
            .frame(maxWidth: .infinity)
            .padding(.top, StoreSelectSheetConstants.dividerPadding)
    }
    
    /// 검색 텍스트 필드
    private var topSearchBar: some View {
        TextField("", text: $viewModel.textSearch, prompt: returnPlaceholder())
            .font(.mainTextSemiBold12)
            .padding(.top, StoreSelectSheetConstants.textFieldTopPadding)
            .padding(.leading, StoreSelectSheetConstants.textFieldLeadingPadding)
            .padding(.bottom, StoreSelectSheetConstants.textFieldBottomPadding)
            .frame(height: StoreSelectSheetConstants.textFieldHeight)
            .background {
                RoundedRectangle(cornerRadius: StoreSelectSheetConstants.textFieldCornerRadius)
                    .fill(Color.gray08)
            }
    }
    
    /// 네비게이션 제목
    private var navigationTitle: some View {
        Text(StoreSelectSheetConstants.naviTitle)
            .font(.mainTextMedium16)
            .foregroundStyle(Color.black03)
            .frame(maxWidth: .infinity)
    }
    
    /// 지도 <-> 리스트 전환 버튼
    private var convertListAndMap: some View {
        HStack {
            Spacer()
            Button(action: {
                withAnimation {
                    isMapVisible.toggle()
                }
            }, label: {
                Image(isMapVisible ? .convertList : .convertMap)
            })
        }
    }
    
    // MARK: - MiddleContents
    
    /// 지도/리스트 중 하나를 보여주는 중간 콘텐츠 영역
    @ViewBuilder
    private var middleContents: some View {
        if isMapVisible {
            middleMapContents
        } else {
            Group {
                divider
                middleListContents
            }
            .safeAreaPadding(.horizontal, StoreSelectSheetConstants.topVstackHorizonPadding)
        }
    }
    
    /// 리스트 기반 매장 뷰
    @ViewBuilder
    private var middleListContents: some View {
        if !viewModel.storeList.isEmpty {
            List(viewModel.storeList) { store in
                let imageUrl = viewModel.storeImageMap[store.id]
                StoreCard(store: store.properties, imageUrlStirng: imageUrl)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
            }
            .listRowSpacing(StoreSelectSheetConstants.listSpacing)
            .listStyle(.plain)
            .contentMargins(.horizontal, -StoreSelectSheetConstants.topVstackHorizonPadding, for: .scrollIndicators)
            .contentMargins(.top, StoreSelectSheetConstants.listTopSpacing, for: .scrollContent)
        } else {
            Spacer()
            Text(StoreSelectSheetConstants.emptyDataText)
                .font(.mainTextBold16)
                .foregroundStyle(Color.gray01)
            Spacer()
        }
    }
    
    /// 지도 기반 매장 뷰
    private var middleMapContents: some View {
        MapView(container: container)
            .padding(.top, StoreSelectSheetConstants.dividerPadding)
    }
}

// MARK: - Helper

extension StoreSelectSheetView {
    /// 검색 텍스트 필드의 플레이스홀더 반환
    private func returnPlaceholder() -> Text {
        Text(StoreSelectSheetConstants.searchBarPlaceholder)
            .font(.mainTextSemiBold12)
            .foregroundStyle(Color.gray01)
    }
}

// MARK: - 미리보기

#Preview {
    StoreSelectSheetView(container: DIContainer())
}
