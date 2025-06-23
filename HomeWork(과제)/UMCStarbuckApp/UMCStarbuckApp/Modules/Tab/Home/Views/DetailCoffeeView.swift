//
//  DetailCoffeeView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

/// 커피 상세 정보를 보여주는 화면
struct DetailCoffeeView: View {
    
    // MARK: - Property
    
    /// DI 컨테이너 (뒤로가기 라우팅 등에 사용)
    @EnvironmentObject var container: DIContainer
    
    /// 커피 상세 정보를 관리하는 뷰모델
    @State var viewModel: CoffeeDetailViewModel
    
    // MARK: - Constants
    /// 화면 내에서 사용하는 UI 상수들을 정의한 enum
    fileprivate enum DetailCoffeeConstants {
        static let cornerRadius: CGFloat = 999
        static let topContentsImageHeight: CGFloat = 355
        static let temperatureHeight: CGFloat = 36
        static let middleContentsSpacinfg: CGFloat = 32
        static let descriptionSpacing: CGFloat = 20
        
        static let buttonButtonRectangle: CGFloat = 87
        static let buttonHorizonPadding: CGFloat = 28
        
        static let mainVstackSpacing: CGFloat = 20
        static let middleContentsPadding: CGFloat = 10
        static let titleSpacing: CGFloat = 4
        static let countNum: Int = 2
        
        static let containText: String = "HOT"
        static let mainButtonText: String = "주문하기"
    }
    
    // MARK: - Init
    
    /// 커피 ID를 기반으로 뷰모델을 생성하는 초기화자
    init(coffeeId: UUID) {
        self.viewModel = .init(coffeeId: coffeeId)
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: DetailCoffeeConstants.mainVstackSpacing, content: {
            topContents
            middleContents
            Spacer()
            bottomContents
        })
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            // 뒤로가기 버튼
            ToolbarItem(placement: .topBarLeading, content: {
                Button(action: {
                    container.navigationRouter.pop()
                }, label: {
                    Image(.back)
                })
            })
            
            // 공유 버튼 (동작 없음)
            ToolbarItem(placement: .topBarTrailing, content: {
                Image(.share)
            })
        })
    }
    
    // MARK: - TopContents
    
    /// 상단 커피 이미지 영역
    @ViewBuilder
    private var topContents: some View {
        if let image = viewModel.selectedVariant?.image {
            Image(image)
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
        }
    }
    
    // MARK: - MiddleContents
    
    /// 중간 콘텐츠 영역 (타이틀, 설명, 온도 선택)
    private var middleContents: some View {
        VStack(alignment: .leading, spacing: DetailCoffeeConstants.middleContentsSpacinfg, content: {
            coffeeTitleGroup
            coffeeDescription
            coffeeTemperatureToggle
        })
        .safeAreaPadding(.horizontal, DetailCoffeeConstants.middleContentsPadding)
    }
    
    /// 커피 한글명 + 영어명 그룹
    private var coffeeTitleGroup: some View {
        VStack(alignment: .leading, spacing: DetailCoffeeConstants.titleSpacing, content: {
            coffeeName
            coffeeEnglishName
        })
    }
    
    /// 커피 한글 이름 + NEW 뱃지
    private var coffeeName: some View {
        HStack(alignment: .firstTextBaseline, spacing: DetailCoffeeConstants.titleSpacing, content: {
            Text(viewModel.currentName)
                .font(.mainTextSemiBold24)
                .foregroundStyle(Color.black03)
            
            Image(.new)
        })
    }
    
    /// 커피 영어 이름
    private var coffeeEnglishName: some View {
        Text(viewModel.currentSubName)
            .font(.mainTextSemiBold14)
            .foregroundStyle(Color.gray01)
    }
    
    /// 커피 설명 + 가격 표시
    private var coffeeDescription: some View {
        VStack(alignment: .leading, spacing: DetailCoffeeConstants.descriptionSpacing, content: {
            if let description = viewModel.selectedVariant?.description {
                Text(description.customLineBreak())
                    .font(.mainTextSemiBold14)
                    .foregroundStyle(Color.gray06)
            }
            
            Text("\(viewModel.coffee.price)원")
                .font(.mainTextSemiBold24)
                .foregroundStyle(Color.black03)
        })
    }
    
    /// 온도 선택 토글 혹은 고정 텍스트 뷰
    @ViewBuilder
    private var coffeeTemperatureToggle: some View {
        if viewModel.coffee.availableTemperatures.count == DetailCoffeeConstants.countNum {
            TemperatureToggleView(
                selected: $viewModel.selectredTemperature,
                available: viewModel.coffee.availableTemperatures
            )
        } else {
            temperatureOlyView
        }
    }
    
    /// 온도 고정 커피의 라벨 뷰 (예: "HOT Only")
    private var temperatureOlyView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DetailCoffeeConstants.cornerRadius)
                .fill(Color.clear)
                .stroke(Color.gray00)
                .frame(maxWidth: .infinity)
                .frame(height: DetailCoffeeConstants.temperatureHeight)
            
            Text(viewModel.coffee.temperatureLabel)
                .font(.mainTextSemiBold16)
                .foregroundStyle(
                    viewModel.coffee.temperatureLabel.contains(DetailCoffeeConstants.containText)
                    ? Color.red01
                    : Color.blue01
                )
        }
    }
    
    // MARK: - BottomContents
    
    /// 하단 고정 주문 버튼 영역
    private var bottomContents: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .btnShadow()
                .frame(maxWidth: .infinity)
                .frame(height: DetailCoffeeConstants.buttonButtonRectangle)
            
            MainButton(color: Color.green00, text: DetailCoffeeConstants.mainButtonText, action: {
                print("아무것도 없어요!")
            })
            .padding(.horizontal, DetailCoffeeConstants.buttonHorizonPadding)
        }
    }
}
