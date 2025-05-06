//
//  SuccessISBNView.swift
//  6st_Practice
//
//  Created by Apple Coding machine on 5/5/25.
//

import SwiftUI
import Kingfisher

struct SuccessISBNView: View {
    
    @Bindable var viewModel: ISBNScannerViewModel
    
    init(viewModel: ISBNScannerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            HStack(spacing: 18) {
                bookCoverImage
                
                bookInfoView()
            }
            
            purchaseButton()
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var bookCoverImage: some View {
        if let data = viewModel.bookModel?.thumbnail,
           let url = URL(string: data) {
            KFImage(url)
                .placeholder({
                    ProgressView()
                        .controlSize(.regular)
                })
                .onFailureImage(.bookCover)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 150)
        } else {
            Image(.bookCover)
        }
    }
    
    @ViewBuilder
    private func bookInfoView() -> some View {
        VStack(spacing: 16, content: {
            makeInfoText(title: "도서명", value: viewModel.bookModel?.title ?? "도서명이 없습니다.")
            makeInfoText(title: "저자", value: viewModel.bookModel?.title ?? "저자가 없습니다.")
            makeInfoText(title: "장르", value: viewModel.bookModel?.title ?? "장르가 없습니다.")
            makeInfoText(title: "가격", value: viewModel.bookModel?.title ?? "가격이 없습니다.")
            makeInfoText(title: "책소개", value: viewModel.bookModel?.title ?? "책소개가 없습니다.")
        })
    }
    
    private func makeInfoText(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.caption)
                .foregroundStyle(Color.orange)
            
            Text(value)
                .font(.caption)
                .foregroundStyle(Color.black)
        }
    }
    
    @ViewBuilder
    private func purchaseButton() -> some View {
        Button(action: {
            viewModel.purchaseBook()
        }, label: {
            Text("구매하기")
                .font(.footnote)
                .foregroundStyle(Color.black)
                .frame(maxWidth: 102, maxHeight: 23)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.yellow)
                )
        })
        .frame(maxWidth: 102, maxHeight: 32)
    }
}

#Preview {
    SuccessISBNView(viewModel: .init())
}
