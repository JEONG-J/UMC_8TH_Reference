//
//  PageControl.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

struct PageControl: View {

    // MARK: - Property
    @Binding var currentPage: Int
    let totalPage: Int = 2
    
    fileprivate enum PageControl {
        static let dotSize: CGFloat = 8
        static let dotSpacing: CGFloat = 8
    }
    
    // MARK: - Init
    init(currentPage: Binding<Int>) {
        self._currentPage = currentPage
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: PageControl.dotSpacing, content: {
            ForEach(0..<totalPage, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? .black03 : .clear)
                    .stroke(index == currentPage ? .clear : .gray02)
                    .frame(width: PageControl.dotSize, height: PageControl.dotSize)
            }
        })
    }
}

#Preview {
    PageControl(currentPage: .constant(0))
}
