//
//  PayView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/30/25.
//

import SwiftUI
import SwiftData

struct PayView: View {
    // MARK: - Property
    @State var viewModel: PayViewModel
    @Query var cards: [PayCardInfo] = []
    
    private var selectedCard: PayCardInfo? {
        cards.indices.contains(viewModel.selectedIndex) ? cards[viewModel.selectedIndex] : nil
    }
    
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    // MARK: - Constant
    fileprivate enum PayConstants {
        static let topImageCornerRadius: CGFloat = 8
        static let topVSpacing: CGFloat = 23
        static let middleVSpacing: CGFloat = 8
        static let naviHorizonPadding: CGFloat = 23
        
        static let cardWidth: CGFloat = 272
        static let cardHeight: CGFloat = 143
        static let geomeryHeight: CGFloat = 150
        
        static let cardTimerText: String = "카드 유효 시간"
        static let cardExpireText: String = "카드 유효시간이 만료되었습니다."
        static let leadingNaviText: String = "Pay"
    }
    
    // MARK: Body
    var body: some View {
        VStack(spacing: PayConstants.topVSpacing, content: {
            topNavigation
            topContents
            cardNameBalance
            cardNumberTimer
            
            Spacer()
        })
        .sheet(isPresented: $viewModel.showAddCard, content: {
            AddPayCardView(container: viewModel.container)
        })
    }
    
    // MARK: - TopContants
    private var topNavigation: some View {
        HStack {
            Text(PayConstants.leadingNaviText)
                .font(.mainTextBold24)
                .foregroundStyle(Color.black03)
            
            Spacer()
            
            Button(action: {
                viewModel.showAddCard.toggle()
            }, label: {
                Image(.plusIcon)
            })
        }
        .safeAreaPadding(.horizontal, PayConstants.naviHorizonPadding)
    }
    
    private var topContents: some View {
        GeometryReader { proxy in
            let screenMidX = proxy.size.width / 2
            cardScrollView(screenMidX: screenMidX)
        }
        .frame(height: PayConstants.geomeryHeight)
    }
    
    private func cardScrollView(screenMidX: CGFloat) -> some View {
        ScrollView(.horizontal, content: {
            cardList(screenMidx: screenMidX)
        })
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
        .scrollTargetLayout()
        .onPreferenceChange(CenterCardPreferenceKey.self, perform: { newIndex in
            if let index = newIndex {
                viewModel.selectedIndex = index
            }
        })
    }
    
    private func cardList(screenMidx: CGFloat) -> some View {
        HStack(spacing: .zero, content: {
            ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                GeometryReader { geo in
                    let midX = geo.frame(in: .global).midX
                    let distance = abs(midX - screenMidx)
                    let scale = max(0.3, 1 - (distance / screenMidx) * 0.2)
                    
                    Color.clear
                        .preference(key: CenterCardPreferenceKey.self, value: distance < PayConstants.cardWidth / 2 ? index : nil)
                    
                    cardImage(scale: scale, card: card)
                }
                .frame(width: PayConstants.cardWidth, height: PayConstants.geomeryHeight)
            }
        })
        .padding(.horizontal, (getScreenSize().width - PayConstants.cardWidth) / 2)
    }
    
    private func cardImage(scale: CGFloat, card: PayCardInfo) -> some View {
        let image: Image = {
            if let uiImage = UIImage(data: card.imageData), !card.imageData.isEmpty {
                return Image(uiImage: uiImage)
            } else {
                return Image(.defaultCard)
            }
        }()
        
        return image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: PayConstants.cardWidth, height: PayConstants.cardHeight)
            .clipShape(RoundedRectangle(cornerRadius: PayConstants.topImageCornerRadius))
            .scaleEffect(scale)
            .animation(.easeInOut, value: scale)
    }
    
    // MARK: - MiddleContents
    @ViewBuilder
    private var cardNameBalance: some View {
        if let selectedCard = selectedCard {
            VStack(spacing: PayConstants.middleVSpacing) {
                Text(selectedCard.cardName)
                    .font(.mainTextMedium13)
                    .foregroundStyle(Color.gray06)
                
                Text("\(selectedCard.balance)원")
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(Color.black)
            }
        }
    }
    
    @ViewBuilder
    private var cardNumberTimer: some View {
        if let selectedCard = selectedCard {
            
            VStack(spacing: PayConstants.middleVSpacing, content: {
                Text(selectedCard.maskedCardNumber)
                    .font(.mainTextRegular12)
                    .foregroundStyle(Color.black)
                
                HStack {
                    Text(PayConstants.cardTimerText)
                        .foregroundStyle(Color.gray04)
                    
                    if viewModel.remainingTime <= 0 {
                        Text(PayConstants.cardExpireText)
                            .foregroundStyle(Color.gray04)
                    } else {
                        Text(viewModel.formattedTime)
                            .foregroundStyle(Color.green00)
                    }
                }
                .font(.mainTextRegular12)
            })
        }
    }
}

struct CenterCardPreferenceKey: PreferenceKey {
    static var defaultValue: Int? = nil
    
    static func reduce(value: inout Int?, nextValue: () -> Int?) {
        if let next = nextValue() {
            value = next
        }
    }
}

#Preview {
    PayView(container: DIContainer())
}
