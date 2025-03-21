//
//  RainbowView.swift
//  3st_Practice
//
//  Created by Apple Coding machine on 3/21/25.
//

import SwiftUI

struct RainbowView: View {
    
    var viewModel: RainbowViewModel = .init()
    @State private var navigationTrue: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                colorCardGroup
                
                Spacer()
                
                bottomSelecteColorGroup
            }
            .safeAreaPadding(EdgeInsets(top: 47, leading: 15, bottom: 43, trailing: 15))
            .navigationDestination(isPresented: $navigationTrue, destination: {
                ColorNavigationView(viewModel: viewModel)
            })
        }
    }
    
    /// 무지개 일곱가지 색상
    private var colorCardGroup: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 40), count: 3), spacing: 26, content: {
            ForEach(RainbowModel.allCases, id: \.self, content: { rainbow in
                makeColorCard(rainbow)
                    .onTapGesture {
                        viewModel.selectedRainbowModel = rainbow
                        self.navigationTrue.toggle()
                    }
            })
        })
    }
    
    /// 반복 생성을 재사용하기 위한 무지개 색상 카드 뷰
    /// - Parameter model: 무지개 색을 담고 있는 모델
    /// - Returns: 색을 표현하는 카드 뷰 반환
    private func makeColorCard(_ model: RainbowModel) -> some View {
        VStack(spacing: 6, content: {
            Rectangle()
                .fill(model.returnColor())
            
            Text(model.returnColorName())
                .foregroundStyle(Color.black)
                .font(.title)
        })
        .frame(maxWidth: .infinity, minHeight: 110)
    }
    
    /// 하단 사과로고 및 선택된 색상 텍스트 그룹
    private var bottomSelecteColorGroup: some View {
        VStack(spacing: 70, content: {
            Image(.appleLogo)
                .renderingMode(.template)
                .fixedSize()
                .foregroundStyle(viewModel.appleLogoColor ?? Color.black)
            
            Text("현재 선택된 색상 : \(selectedColorName())")
                .font(.title)
                .foregroundStyle(Color.black)
        })
    }
    
    /// 옵셔널에 대해 값 처리를 위한 String 반환 함수
    /// - Returns: 옵셔널 값에 따른 두 가지 중 하나 값 반환
    private func selectedColorName() -> String {
        if let name = viewModel.selectedRainbowModel {
            return name.returnColorName()
        } else {
            return "아무것도 없음"
        }
    }
    
}

#Preview {
    RainbowView()
}
