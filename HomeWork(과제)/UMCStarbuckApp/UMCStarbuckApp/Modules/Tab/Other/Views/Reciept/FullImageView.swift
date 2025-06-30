//
//  FullImageView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import SwiftUI

struct FullImageView: View {
    
    // MARK: - Property
    let imageData: Data
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Constant
    fileprivate enum FullImageConstants {
        static let erroMessage: String = "이미지를 불러올 수 없어요"
        static let backgrounOpacity: Double = 0.8
        static let closeTopPadding: CGFloat = 18
        static let closeTrailingPadding: CGFloat = 16
    }
    
    // MARK: - Init
    init(imageData: Data) {
        self.imageData = imageData
    }
    
    var body: some View {
        ZStack(alignment: .center, content: {
            Color.black.opacity(FullImageConstants.backgrounOpacity)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            imageContents
        })
    }
    
    private var closeButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(.close)
                .padding(.top, FullImageConstants.closeTopPadding)
                .padding(.trailing, FullImageConstants.closeTrailingPadding)
        })
    }
    
        @ViewBuilder
        private var imageContents: some View {
            if let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(alignment: .topTrailing, content: {
                        closeButton
                    })
            }
        }
}
