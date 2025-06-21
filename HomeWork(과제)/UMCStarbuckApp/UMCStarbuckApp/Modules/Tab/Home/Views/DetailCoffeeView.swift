//
//  DetailCoffeeView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

struct DetailCoffeeView: View {
    
    // MARK: - Property
    @EnvironmentObject var container: DIContainer
    @State var viewModel: CoffeeDetailViewModel
    
    // MARK: - Constants
    fileprivate enum DetailCoffeeConstants {
        static let cornerRadius: CGFloat = 999
        static let topContentsImageHeight: CGFloat = 355
        static let temperatureHeight: CGFloat = 36
        static let middleContentsSpacinfg: CGFloat = 32
        static let descriptionSpacing: CGFloat = 20
        
        static let buttonButtonRectangle: CGFloat = 73
        static let buttonHorizonPadding: CGFloat = 28
        
        static let mainVstackSpacing: CGFloat = 20
        static let middleContentsPadding: CGFloat = 10
        static let titleSpacing: CGFloat = 4
        static let countNum: Int = 2
        
        static let containText: String = "HOT"
        static let mainButtonText: String = "주문하기"
    }
    
    // MARK: - Init
    init(coffee: CoffeeMenuItem) {
        self.viewModel = .init(coffee: coffee)
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: DetailCoffeeConstants.mainVstackSpacing, content: {
            topContents
            middleContents
            Spacer()
            bottomContents
        })
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading, content: {
                Image(.back)
            })
            
            ToolbarItem(placement: .topBarTrailing, content: {
                Image(.share)
            })
        })
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - TopContents
    @ViewBuilder
    private var topContents: some View {
        if let image = viewModel.selectedVariant?.image {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: DetailCoffeeConstants.topContentsImageHeight)
                .ignoresSafeArea()
        }
    }
    
    // MARK: - MiddleContents
    private var middleContents: some View {
        VStack(alignment: .leading, spacing: DetailCoffeeConstants.middleContentsSpacinfg, content: {
            coffeeTitleGroup
            coffeeDescription
            coffeeTemperatureToggle
        })
        .safeAreaPadding(.horizontal, DetailCoffeeConstants.middleContentsPadding)
    }
    
    private var coffeeTitleGroup: some View {
        VStack(alignment: .leading, spacing: DetailCoffeeConstants.titleSpacing, content: {
            coffeeName
            coffeeEnglishName
        })
    }
    
    private var coffeeName: some View {
        HStack(alignment: .firstTextBaseline,spacing: DetailCoffeeConstants.titleSpacing, content: {
            Text(viewModel.currentName)
                .font(.mainTextSemiBold24)
                .foregroundStyle(Color.black03)
            
            Image(.new)
        })
    }
    
    private var coffeeEnglishName: some View {
        Text(viewModel.currentSubName)
            .font(.mainTextSemiBold14)
            .foregroundStyle(Color.gray01)
    }
    
    private var coffeeDescription: some View {
        VStack(alignment: .leading, spacing: DetailCoffeeConstants.descriptionSpacing, content: {
            if let description = viewModel.selectedVariant?.description {
                Text(description)
                    .font(.mainTextSemiBold14)
                    .foregroundStyle(Color.gray06)
            }
            
            Text("\(viewModel.coffee.price)원")
                .font(.mainTextSemiBold24)
                .foregroundStyle(Color.black03)
        })
    }
    
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
    
    private var temperatureOlyView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DetailCoffeeConstants.cornerRadius)
                .fill(Color.clear)
                .stroke(Color.gray00)
                .frame(maxWidth: .infinity)
                .frame(height: DetailCoffeeConstants.temperatureHeight)
            
            Text(viewModel.coffee.temperatureLabel)
                .font(.mainTextSemiBold16)
                .foregroundStyle(viewModel.coffee.temperatureLabel.contains(DetailCoffeeConstants.containText) ? Color.red01 : Color.blue01)
        }
    }
    
    // MARK: - BottomContents
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

#Preview {
    DetailCoffeeView(coffee: .init(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
        name: "아이스 카페 아메리카노",
        subName: "Iced Caffe Americano",
        price: 4700,
        variants: [
            .iced: .init(
                image: .americanpCold,
                description: "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피"
            ),
            .hot: .init(
                image: .americanoHot,
                description: "진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피"
            )
        ],
        temperatureNames: [
            .iced: ("아이스 카페 아메리카노", "Iced Caffe Americano"),
            .hot: ("카페 아메리카노", "Caffe Americano")
        ]
    ))
    .environmentObject(DIContainer())
}
