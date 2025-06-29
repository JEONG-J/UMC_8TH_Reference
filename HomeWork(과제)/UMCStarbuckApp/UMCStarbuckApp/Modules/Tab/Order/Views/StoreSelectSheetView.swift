//
//  StoreSelectSheetView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import SwiftUI

struct StoreSelectSheetView: View {
    
    // MARK: - Property
    @State var viewModel: StoreSelectSheetViewModel
    @State private var isMapVisible: Bool = false
    @EnvironmentObject var container: DIContainer
    
    // MARK: - Constants
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
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: .zero, content: {
            topContents
            middleContents
        })
        .safeAreaPadding(.top, StoreSelectSheetConstants.topVstackTopPadding)
        .task {
            await viewModel.getAllStores()
        }
        .onChange(of: viewModel.locationManager.currentLocation) { old, new in
            if new != nil {
                Task {
                    await viewModel.nearByStores()
                }
            }
        }
        .overlay(content: {
            if viewModel.isLoading {
                ProgressView()
                    .controlSize(.large)
                    .tint(Color.green02)
            }
        })
    }
    
    // MARK: - TopContents
    private var topContents: some View {
        VStack(spacing: StoreSelectSheetConstants.topVstackSpacing, content: {
            topCapsule
            topNavigationBar
            searchContents
        })
        .safeAreaPadding(.horizontal, StoreSelectSheetConstants.topVstackHorizonPadding)
    }
    
    private var topCapsule: some View {
        Capsule()
            .fill(Color.gray04)
            .frame(width: StoreSelectSheetConstants.capsuleWidth, height: StoreSelectSheetConstants.capsuleHeight)
    }
    
    private var topNavigationBar: some View {
        ZStack {
            navigationTitle
            convertListAndMap
        }
    }
    
    private var searchContents: some View {
        VStack(alignment: .leading, spacing: StoreSelectSheetConstants.searchContentsSpacing, content: {
            topSearchBar
            StoreSearchSegment(storeSearchType: $viewModel.storeSearchType)
        })
    }
    
    private var divider: some View {
        Divider()
            .foregroundStyle(Color.gray07)
            .frame(maxWidth: .infinity)
            .padding(.top, StoreSelectSheetConstants.dividerPadding)
    }
    
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
    
    private var navigationTitle: some View {
        Text(StoreSelectSheetConstants.naviTitle)
            .font(.mainTextMedium16)
            .foregroundStyle(Color.black03)
            .frame(maxWidth: .infinity)
    }
    
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
    
    @ViewBuilder
    private var middleListContents: some View {
        if !viewModel.storeList.isEmpty {
            List(viewModel.storeList) { store in
                StoreCard(store: store.properties, imageUrlStirng: viewModel.googleStoreImageUrl)
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
    
    private var middleMapContents: some View {
        MapView(container: container)
            .padding(.top, StoreSelectSheetConstants.dividerPadding)
    }
}

extension StoreSelectSheetView {
    private func returnPlaceholder() -> Text {
        Text(StoreSelectSheetConstants.searchBarPlaceholder)
            .font(.mainTextSemiBold12)
            .foregroundStyle(Color.gray01)
    }
}

#Preview {
    StoreSelectSheetView(container: DIContainer())
}
