//
//  PayView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/30/25.
//

import SwiftUI
import SwiftData

/// 스타벅스 카드 결제 뷰
struct PayView: View {
    // MARK: - Property

    /// 뷰모델: 카드 정보, 선택 인덱스, 상태값 등을 관리
    @State var viewModel: PayViewModel

    /// 저장된 카드 목록을 최신순으로 정렬하여 불러옴
    @Query(sort: [SortDescriptor(\PayCardInfo.createdAt, order: .reverse)]) var cards: [PayCardInfo]

    /// 현재 선택된 카드
    private var selectedCard: PayCardInfo? {
        cards.indices.contains(viewModel.selectedIndex) ? cards[viewModel.selectedIndex] : nil
    }

    /// DIContainer를 통한 의존성 주입
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }

    // MARK: - Constant

    /// 뷰 전체에서 사용되는 UI 상수 정의
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

    // MARK: - Body

    var body: some View {
        VStack(spacing: PayConstants.topVSpacing, content: {
            topNavigation
            topContents
            cardNameBalance
            cardNumberTimer
            Spacer()
        })
        // 카드 추가 화면을 sheet로 표시
        .sheet(isPresented: $viewModel.showAddCard, content: {
            AddPayCardView(container: viewModel.container)
        })
    }

    // MARK: - Top UI

    /// 상단 내비게이션 바
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

    /// 카드 스크롤 뷰 포함하는 영역
    private var topContents: some View {
        GeometryReader { proxy in
            let screenMidX = proxy.size.width / 2
            cardScrollView(screenMidX: screenMidX)
        }
        .frame(height: PayConstants.geomeryHeight)
    }

    /// 카드 가로 스크롤 뷰
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

    /// 카드 리스트 (줌 효과 포함)
    private func cardList(screenMidx: CGFloat) -> some View {
        HStack(spacing: .zero, content: {
            ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                GeometryReader { geo in
                    let midX = geo.frame(in: .global).midX
                    let distance = abs(midX - screenMidx)
                    let scale = max(0.3, 1 - (distance / screenMidx) * 0.2)

                    // 현재 가운데 카드의 인덱스를 Preference로 전달
                    Color.clear
                        .preference(key: CenterCardPreferenceKey.self, value: distance < PayConstants.cardWidth / 2 ? index : nil)

                    cardImage(scale: scale, card: card)
                }
                .frame(width: PayConstants.cardWidth, height: PayConstants.geomeryHeight)
            }
        })
        .padding(.horizontal, (getScreenSize().width - PayConstants.cardWidth) / 2)
    }

    /// 카드 이미지 뷰 (줌 효과 포함)
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
            .aspectRatio(contentMode: .fill)
            .frame(width: PayConstants.cardWidth, height: PayConstants.cardHeight)
            .clipShape(RoundedRectangle(cornerRadius: PayConstants.topImageCornerRadius))
            .scaleEffect(scale)
            .animation(.easeInOut, value: scale)
    }

    // MARK: - Middle UI

    /// 카드 이름 및 잔액 표시
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

    /// 카드 번호 및 타이머 표시
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

/// 가운데 카드의 인덱스를 추적하기 위한 PreferenceKey
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
