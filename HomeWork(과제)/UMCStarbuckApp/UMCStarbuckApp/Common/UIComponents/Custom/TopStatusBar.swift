//
//  TopStatusBar.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import SwiftUI

struct TopStatusBar: View {
    
    // MARK: - Constants
    fileprivate enum TopStatusBarConstants {
        static let title: String = "Other"
        static let horizontalPadding: CGFloat = 24
        static let bottomPadding: CGFloat = 16
        static let height: CGFloat = 120
    }
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            Color.white
            contents
        })
        .frame(height: TopStatusBarConstants.height)
    }
    
    private var contents: some View {
        HStack {
            Text(TopStatusBarConstants.title)
                .font(.mainTextBold24)
                .foregroundStyle(Color.black)
            
            Spacer()
            
            Image(.logOut)
        }
        .safeAreaPadding(.horizontal, TopStatusBarConstants.horizontalPadding)
        .safeAreaPadding(.bottom, TopStatusBarConstants.bottomPadding)
    }
}
