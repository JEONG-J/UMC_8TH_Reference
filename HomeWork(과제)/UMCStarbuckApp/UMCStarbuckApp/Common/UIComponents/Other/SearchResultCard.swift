//
//  SearchResult.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/30/25.
//

import SwiftUI

struct SearchResultCard: View {
    
    // MARK: - Property
    var searchResult: SearchResult
    
    // MARK: - Constants
    fileprivate enum SearchResultConstants {
        static let vSpacing: CGFloat = 8
    }
    
    // MARK: - Init
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: SearchResultConstants.vSpacing, content: {
            Text(searchResult.name)
                .font(.mainTextMedium16)
                .foregroundStyle(Color.black)
            
            Text(searchResult.address)
                .font(.mainTextMedium13)
                .foregroundStyle(Color.gray04)
        })
    }
}
