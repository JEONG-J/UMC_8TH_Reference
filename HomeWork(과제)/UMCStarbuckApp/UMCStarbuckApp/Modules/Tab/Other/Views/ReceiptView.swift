//
//  ReceiptView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct ReceiptView: View {
    // MARK: - Property
    @State var viewModel: ReceiptViewModel
    @Query private var receipts: [ReceiptModel]
    @Environment(\.modelContext) private var context
    @EnvironmentObject var container: DIContainer
    
    private var totalAmount: Int {
        receipts.reduce(0) { $0 + $1.price}
    }
    
    // MARK: - Constants
    fileprivate enum ReceiptConstants {
        static let topNaviRectangleHeight: CGFloat = 96
        static let listVstackSpacing: CGFloat = 24
        static let allContentsVstackSpacing: CGFloat = 16
        
        static let totalCountText: String = "총 "
        static let totalPriceText: String = "사용합계 "
        static let navigationTitle: String = "전자 영수증"
        static let confirDialogText: String = "영수증을 어떻게 추가할까요?"
    }
    
    // MARK: - Init
    init() {
        self.viewModel = .init()
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top, content: {
            Color.white01
            allContents
        })
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .customNavigation(
            title: ReceiptConstants.navigationTitle,
            leadingAction: {
                container.navigationRouter.pop()
            },
            trailingAction: {
                viewModel.showConfirmDialog.toggle()
            }
        )
        .confirmationDialog(ReceiptConstants.confirDialogText, isPresented: $viewModel.showConfirmDialog, titleVisibility: .visible, actions: {
            confirDialog
        })
        .photosPicker(
            isPresented: $viewModel.showPhotoPicker,
            selection: $viewModel.selectedItem,
            matching: .images,
            photoLibrary: .shared())
        .onChange(of: viewModel.selectedItem, { old, new in
            Task {
                await viewModel.loadImage(new)
            }
        })
        .onChange(of: viewModel.recognizedReceipt, { old, new in
            guard let receipt = new else  { return }
            
            context.insert(receipt)
            try? context.save()
            
            viewModel.resetRecognizedReceipt()
        })
        .fullScreenCover(item: $viewModel.identifiableImageData, content: { imageData in
            FullImageView(imageData: imageData.data)
        })
    }
    
    private var allContents: some View {
        VStack(spacing: ReceiptConstants.allContentsVstackSpacing, content: {
            topContents
            middleContents
        })
    }
    
    // MARK: - TopContents
    private var topContents: some View {
        Rectangle()
            .fill(Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: ReceiptConstants.topNaviRectangleHeight)
    }
    
    // MARK: - MiddleContents
    
    private var middleContents: some View {
        VStack(alignment: .leading, spacing: ReceiptConstants.listVstackSpacing, content: {
            listHeaderContents
            listMiddleContents
        })
    }
    
    private var listHeaderContents: some View {
        HStack {
            ( makeInfoText(ReceiptConstants.totalCountText) + makeValueText("\(receipts.count)건") )
            Spacer()
            ( makeInfoText(ReceiptConstants.totalPriceText) + makeValueText("\(totalAmount.formattedWithComma())") )
        }
        .padding(.leading, UIConstants.defaultHorizontalPadding)
        .padding(.trailing, UIConstants.defaultHorizontalPadding - 2)
    }
    
    private var listMiddleContents: some View {
        List {
            ForEach(receipts, id: \.id) { receipt in
                ReceiptRowCard(receipt: receipt)
                    .onTapGesture {
                        self.listAction(receipt)()
                    }
            }
            .onDelete(perform: deleteItems)
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        
    }
    
    // MARK: - ConfirmDialog
    @ViewBuilder
    private var confirDialog: some View {
        ForEach(ConfirmDialogType.allCases, id: \.id) { action in
            Button(action.title, role: action.role, action: {
                Task {
                    await viewModel.actionConfirDialog(action)
                }
            })
        }
    }
}

extension ReceiptView {
    // MARK: - Method
    private func deleteItems(_ offsets: IndexSet) {
        for index in offsets {
            let deletedReceipt = receipts[index]
            
            if let selectedImage = viewModel.selectedImage,
               let receiptImage = deletedReceipt.imageData,
               selectedImage.pngData() == receiptImage {
                viewModel.resetRecognizedReceipt()
            }
            
            context.delete(deletedReceipt)
        }
        
        try? context.save()
    }
    
    private func makeInfoText(_ text: String) -> Text {
        Text(text)
            .font(.mainTextRegular18)
            .foregroundStyle(Color.black)
    }
    
    private func makeValueText(_ text: String) -> Text{
        Text(text)
            .font(.mainTextSemiBold18)
            .foregroundStyle(Color.brown01)
    }
    
    private func listAction(_ receipt: ReceiptModel) -> () -> Void {
        return {
            if let imageData = receipt.imageData {
                viewModel.identifiableImageData = .init(data: imageData)
            }
        }
    }
}
