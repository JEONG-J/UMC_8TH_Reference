//
//  ReceiptRowView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import SwiftUI

struct ReceiptRowCard: View {
    // MARK: - Property
    let receipt: ReceiptModel
    
    // MARK: - Constants
    fileprivate enum ReceiptConstants {
        static let vstackSpacing: CGFloat = 9
    }
    
    // MARK: - Init
    init(receipt: ReceiptModel) {
        self.receipt = receipt
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            leftContents
            Spacer()
            Image(.receiptShow)
        }
        .contentShape(Rectangle())
    }
    
    // MARK: - Contents
    private var leftContents: some View {
        VStack(alignment: .leading, spacing: ReceiptConstants.vstackSpacing, content: {
            Text(receipt.stroeName)
                .font(.mainTextSemiBold18)
                .foregroundStyle(Color.black)
            
            Text(receipt.date.formattedDateString())
                .font(.mainTextMedium16)
                .foregroundStyle(Color.gray03)
            
            Text("\(receipt.price)원")
                .font(.mainTextSemiBold18)
                .foregroundStyle(Color.brown02)
        })
    }
}
