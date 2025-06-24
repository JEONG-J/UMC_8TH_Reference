//
//  OrderBottomStatus.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import SwiftUI

struct OrderBottomStatus: View {
    
    // MARK: - Property
    @Binding var showMapSheet: Bool
    @Binding var storeAddressName: String?
    
    // MARK: - Constants
    fileprivate enum OrderBottomStatusConstants {
        static let statatusTitle: String = "주문할 매장을 선택해주세요"
        static let spacing: CGFloat = 7
        static let horizonPadding: CGFloat = 20
        static let topPadding: CGFloat = 10
        static let bottomPadding: CGFloat = 21
    }
    
    // MARK: - Init
    init(
        showMapSheet: Binding<Bool>,
        storeAddressName: Binding<String?>
    ) {
        self._showMapSheet = showMapSheet
        self._storeAddressName = storeAddressName
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: OrderBottomStatusConstants.spacing, content: {
            statusTitle
            Divider()
                .background(Color.gray06)
        })
        .padding(.horizontal, OrderBottomStatusConstants.horizonPadding)
        .padding(.top, OrderBottomStatusConstants.topPadding)
        .padding(.bottom, OrderBottomStatusConstants.bottomPadding)
        .background {
            Rectangle()
                .fill(Color.black02)
                .frame(maxWidth: .infinity)
        }
        .onTapGesture {
            showMapSheet.toggle()
        }
    }
    
    private var statusTitle: some View {
        HStack {
            Text(storeAddressName ?? OrderBottomStatusConstants.statatusTitle)
                .font(.mainTextSemiBold16)
                .foregroundStyle(Color.white)
            Spacer()
            Image(.downIcon)
        }
    }
}

#Preview {
    OrderBottomStatus(showMapSheet: .constant(true), storeAddressName: .constant("주문할 매장을 선택해 주세요!"))
}
