//
//  SearchRoadView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/29/25.
//

import SwiftUI

struct SearchRoadView: View {
    // MARK: - Property
    @Bindable var viewModel: FindStoreViewModel
    @FocusState var focusedField: RoutePosition?
    
    // MARK: - Constants
    fileprivate enum SearchRoadConstant {
        static let hSpacing: CGFloat = 15
        static let hInnerSpacing: CGFloat = 8
        static let vTopSpacing: CGFloat = 13
        static let contentsVspacing: CGFloat = 28
        static let prgoressHspacing: CGFloat = 8
        
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
        static let progressText: String = "경로 검색 중.."
    }
    
    init(viewModel: FindStoreViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Init
    var body: some View {
        VStack(spacing: SearchRoadConstant.contentsVspacing, content: {
            topContents
            middleContents
        })
        .customDetail(content: {
            if viewModel.isSearchLoading {
                progressView
            } else if viewModel.showSearchAlert {
                StoreSearchAlert(showAlert: $viewModel.showSearchAlert)
            }
        })
    }
    
    // MARK: - TopContents
    private var topContents: some View {
        VStack(
            spacing: SearchRoadConstant.vTopSpacing, content: {
                ForEach(RoutePosition.allCases, id: \.self) { type in
                    makeInnerContents(type)
                }
                MainButton(
                    color: .green00,
                    text: SearchRoadConstant.searchText,
                    height: SearchRoadConstant.searchBtnHeight,
                    cornerRadius: SearchRoadConstant.mainBtnCornerRadius,
                    action: {
                        print("API 호출")
                    })
            })
        .safeAreaPadding(.horizontal, SearchRoadConstant.topContentsPadding)
    }
    
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
    private var middleContents: some View {
        ScrollView(.vertical, content: {
            LazyVStack(alignment: .leading, spacing: SearchRoadConstant.contentsVspacing, content: {
                ForEach(Array(viewModel.searchResult.enumerated()), id: \.offset) { index, result in
                    SearchResultCard(searchResult: result)
                        .safeAreaPadding(.horizontal, SearchRoadConstant.middleContentsPadding)
                        .onTapGesture {
                            cardOnTapGesture(name: result.name)
                        }
                    if index < viewModel.searchResult.count - 1 {
                        Divider()
                            .background(Color.gray04)
                    }
                }
            })
        })
    }
    
    // MARK: - Progress
    private var progressView: some View {
        HStack(spacing: SearchRoadConstant.prgoressHspacing, content: {
            ProgressView()
                .tint(Color.green00)
            
            Text(SearchRoadConstant.progressText)
                .font(.mainTextMedium16)
                .foregroundStyle(Color.white)
        })
    }
}

extension SearchRoadView {
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
                onSubmitAction(type: type)
            }, label: {
                Image(.searchGlass)
            })
        })
    }
    
    private func placeholder(_ type: RoutePosition) -> Text {
        Text(type.placeholder)
            .font(.mainTextRegular13)
            .foregroundStyle(Color.gray03)
    }
    
    private func buttonAction() -> Void {
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
    
    private func onSubmitAction(type: RoutePosition) -> Void {
        switch type {
        case .departure:
            print("1")
        case .arrival:
            print("2")
        }
    }
    
    private func cardOnTapGesture(name: String) -> Void {
        switch focusedField {
        case .departure:
            viewModel.textfieldValue[.departure] = name
        case .arrival:
            viewModel.textfieldValue[.arrival] = name
        default:
            return print("hello")
        }
    }
}

#Preview {
    SearchRoadView(viewModel: .init(container: DIContainer()))
}
