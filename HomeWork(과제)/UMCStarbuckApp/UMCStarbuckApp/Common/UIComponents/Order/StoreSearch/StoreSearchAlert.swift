//
//  StoreSearchAlert.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/30/25.
//

import SwiftUI

struct StoreSearchAlert: View {
    // MARK: - Property
    @Binding var showAlert: Bool
    
    // MARK: - Constants
    fileprivate enum StoreSearchConstants {
        static let corenrRadius: CGFloat = 6
        static let vSpacing: CGFloat = 16
        static let vStackBottomOffset: CGFloat = -13
        static let topDividerPadding: CGFloat = 2
        
        static let alertWarningText: String = "해당 검색어로 조회된 매장정보가 존재하지 않아요!"
        static let alertCheckText: String = "확인"
    }
    
    // MARK: - Init
    init(showAlert: Binding<Bool>) {
        self._showAlert = showAlert
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom, content: {
            RoundedRectangle(cornerRadius: StoreSearchConstants.corenrRadius)
                .fill(Color.white01)
                .alertShadow()
            
            contents
        })
        .frame(maxWidth: .infinity, maxHeight: 118)
    }
    
    private var contents: some View {
        VStack(spacing: StoreSearchConstants.vSpacing, content: {
            Text(StoreSearchConstants.alertWarningText)
                .font(.mainTextSemiBold14)
                .foregroundStyle(Color.gray03)
            
            Divider()
                .background(Color.gray01)
                .padding(.top, StoreSearchConstants.topDividerPadding)
            
            Button(action: {
                showAlert.toggle()
            }, label: {
                Text(StoreSearchConstants.alertCheckText)
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(Color.green02)
            })
        })
        .offset(y: StoreSearchConstants.vStackBottomOffset)
    }
}

#Preview {
    StoreSearchAlert(showAlert: .constant(true))
}
