//
//  SearchRoadView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/29/25.
//

import SwiftUI

/// 경로 검색 뷰 (출발지/도착지 입력 및 결과 표시)
struct SearchRoadView: View {
    // MARK: - Property
    
    /// ViewModel을 바인딩하여 상태 변화를 반영
    @Bindable var viewModel: FindStoreViewModel
    
    /// 텍스트 필드 포커스 상태 관리
    @FocusState var focusedField: RoutePosition?
    
    // MARK: - Constants
    /// 뷰 내부에서 사용할 레이아웃 및 텍스트 상수
    fileprivate enum SearchRoadConstant {
        static let hSpacing: CGFloat = 15
        static let hInnerSpacing: CGFloat = 8
        static let vTopSpacing: CGFloat = 13
        static let contentsVspacing: CGFloat = 28
        
        static let topContentsPadding: CGFloat = 32
        static let middleContentsPadding: CGFloat = 16
        
        static let textFieldVerticalPadding: CGFloat = 7
        static let textFieldLeadingPadding: CGFloat = 9
        static let mainBtnCornerRadius: CGFloat = 10
        
        static let currentBtnPadding: CGFloat = 6
        static let currentBtnCrnerRadius: CGFloat = 6
        static let searchBtnHeight: CGFloat = 38
        
        static let buttonText: String = "현재위치"
        static let searchText: String = "경로 찾기"
    }
    
    /// 초기화 시 ViewModel 주입
    init(viewModel: FindStoreViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: SearchRoadConstant.contentsVspacing, content: {
            topContents     // 입력 필드 및 버튼
            middleContents  // 검색 결과 리스트
        })
        .safeAreaPadding(.top, SearchRoadConstant.contentsVspacing)
        .onChange(of: focusedField, { old, new in
            if let new {
                viewModel.routePosition = new
            }
        })
    }
    
    // MARK: - TopContents
    
    /// 출발지/도착지 입력과 경로찾기 버튼
    private var topContents: some View {
        VStack(
            spacing: SearchRoadConstant.vTopSpacing,
            content: {
                ForEach(RoutePosition.allCases, id: \.self) { type in
                    oneLineContents(type) // 각 필드 (출발/도착)
                }
                MainButton(
                    color: .green00,
                    text: SearchRoadConstant.searchText,
                    height: SearchRoadConstant.searchBtnHeight,
                    cornerRadius: SearchRoadConstant.mainBtnCornerRadius,
                    action: {
                        Task {
                            await viewModel.getRouteInOSRM()
                        }
                    }
                )
            }
        )
        .safeAreaPadding(.horizontal, SearchRoadConstant.topContentsPadding)
    }
    
    private func oneLineContents(_ type: RoutePosition) -> some View {
        HStack(spacing: SearchRoadConstant.hSpacing, content: {
            Text(type.rawValue)
                .font(.mainTextSemiBold16)
                .foregroundStyle(Color.black03)
            
            makeInnerContents(type)
        })
    }
    
    /// 현재 위치 버튼 (출발지 입력 필드 옆에 위치)
    private var currentButton: some View {
        Button(action: {
            buttonAction()
        }, label: {
            Text(SearchRoadConstant.buttonText)
                .font(.mainTextSemiBold13)
                .foregroundStyle(Color.white01)
                .padding(SearchRoadConstant.currentBtnPadding)
                .background {
                    RoundedRectangle(cornerRadius: SearchRoadConstant.currentBtnCrnerRadius)
                        .fill(Color.brown01)
                }
        })
    }
    
    // MARK: - MiddleContents
    
    /// 검색 결과 리스트 (스크롤 가능)
    private var middleContents: some View {
        ScrollView(.vertical, content: {
            LazyVStack(alignment: .leading, spacing: SearchRoadConstant.contentsVspacing, content: {
                ForEach(Array(viewModel.searchResult.enumerated()), id: \.offset) { index, result in
                    SearchResultCard(searchResult: result)
                        .safeAreaPadding(.horizontal, SearchRoadConstant.middleContentsPadding)
                        .onTapGesture {
                            cardOnTapGesture(result: result)
                        }
                    if index < viewModel.searchResult.count - 1 {
                        Divider()
                            .background(Color.gray04)
                    }
                }
            })
        })
    }
}

// MARK: - Extension for Helper Functions

extension SearchRoadView {
    
    /// 출발지/도착지 TextField 생성
    private func makeInnerContents(_ type: RoutePosition) -> some View {
        HStack(spacing: SearchRoadConstant.hInnerSpacing, content: {
            if type.isCurrentButton {
                currentButton
            }
            
            TextField(
                "",
                text: Binding(
                    get: { viewModel.textfieldValue[type] ?? "" },
                    set: { viewModel.textfieldValue[type] = $0 }
                ),
                prompt: placeholder(type)
            )
            .font(.mainTextRegular13)
            .foregroundStyle(Color.black03)
            .padding(.vertical, SearchRoadConstant.textFieldVerticalPadding)
            .padding(.leading, SearchRoadConstant.textFieldLeadingPadding)
            .border(Color.gray01)
            .submitLabel(.done)
            .focused($focusedField, equals: type)
            .onSubmit {
                onSubmitAction(type: type)
            }
            
            Button(action: {
                focusedField = type
                onSubmitAction(type: type)
            }, label: {
                Image(.searchGlass)
            })
        })
    }
    
    /// 텍스트 필드 placeholder 반환
    private func placeholder(_ type: RoutePosition) -> Text {
        Text(type.placeholder)
            .font(.mainTextRegular13)
            .foregroundStyle(Color.gray03)
    }
    
    /// 현재 위치 버튼 클릭 시 주소 자동 입력
    private func buttonAction() {
        LocationManager.shared.reverseGeocodeCurrentLocatoin { address in
            if let address = address {
                DispatchQueue.main.async {
                    viewModel.textfieldValue[.departure] = address
                }
            } else {
                print("주소 정보 없음!")
            }
        }
    }
    
    /// 검색 아이콘 또는 키보드 submit 시 동작
    private func onSubmitAction(type: RoutePosition) {
        switch type {
        case .departure:
            Task {
                await viewModel.searchPlace(position: type)
            }
        case .arrival:
            Task {
                let keyword = viewModel.textfieldValue[type] ?? ""
                await viewModel.searchStores(keyword: keyword)
            }
        }
    }
    
    /// 카드 탭 시 텍스트 필드에 값 채워 넣기
    private func cardOnTapGesture(result: SearchResult) {
        print(result)
        let position = viewModel.routePosition
        viewModel.textfieldValue[position] = result.name
        
        switch position {
        case .departure:
            viewModel.osrmRequestPoint.startPoint = Coordinate(lat: result.coordinate.lat,
                                                                lng: result.coordinate.lng)
        case .arrival:
            viewModel.osrmRequestPoint.endPoint = Coordinate(lat: result.coordinate.lat,
                                                              lng: result.coordinate.lng)
        }
        
        viewModel.searchResult.removeAll()
    }
}


#Preview {
    SearchRoadView(viewModel: .init(container: DIContainer()))
}
