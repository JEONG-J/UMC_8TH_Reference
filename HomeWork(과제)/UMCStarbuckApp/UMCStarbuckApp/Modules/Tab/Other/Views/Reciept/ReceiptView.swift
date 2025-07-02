//
//  ReceiptView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import SwiftUI
import SwiftData
import PhotosUI

/// 사용자의 영수증 목록을 보여주고, OCR로 영수증을 추가할 수 있는 화면
struct ReceiptView: View {
    
    // MARK: - Property
    
    /// 뷰모델 상태
    @State var viewModel: ReceiptViewModel
    
    /// 영수증 목록 (SwiftData의 @Query를 통해 자동 업데이트됨)
    @Query private var receipts: [ReceiptModel]
    
    /// SwiftData의 모델 컨텍스트 (삽입/삭제/저장에 사용)
    @Environment(\.modelContext) private var context
    
    /// DIContainer: 전역 종속성 관리
    @EnvironmentObject var container: DIContainer
    
    /// 총 사용 금액 계산
    private var totalAmount: Int {
        receipts.reduce(0) { $0 + $1.price }
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
        
        // 이미지 선택 후 OCR 실행
        .onChange(of: viewModel.selectedItem, { old, new in
            Task {
                await viewModel.loadImage(new)
                viewModel.isLoading = false
            }
        })
        
        // OCR 후 파싱된 영수증 저장
        .onChange(of: viewModel.recognizedReceipt, { old, new in
            guard let receipt = new else { return }
            context.insert(receipt)
            try? context.save()
            viewModel.resetRecognizedReceipt()
        })
        
        // 전체 화면 이미지 뷰어
        .fullScreenCover(item: $viewModel.identifiableImageData, content: { imageData in
            FullImageView(imageData: imageData.data)
        })
        
        // 로딩 인디케이터
        .overlay(content: {
            if viewModel.isLoading {
                ProgressView()
                    .controlSize(.large)
                    .tint(Color.green02)
            }
        })
    }
    
    /// 전체 콘텐츠 구성 (상단 + 리스트)
    private var allContents: some View {
        VStack(spacing: ReceiptConstants.allContentsVstackSpacing, content: {
            topContents
            middleContents
        })
    }
    
    // MARK: - TopContents
    
    /// 상단 네비게이션 영역 배경
    private var topContents: some View {
        Rectangle()
            .fill(Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: ReceiptConstants.topNaviRectangleHeight)
    }
    
    // MARK: - MiddleContents
    
    /// 영수증 리스트 영역
    private var middleContents: some View {
        VStack(alignment: .leading, spacing: ReceiptConstants.listVstackSpacing, content: {
            listHeaderContents
            listMiddleContents
        })
    }
    
    /// 리스트 헤더 (총 개수, 총 금액 표시)
    private var listHeaderContents: some View {
        HStack {
            ( makeInfoText(ReceiptConstants.totalCountText) + makeValueText("\(receipts.count)건") )
            Spacer()
            ( makeInfoText(ReceiptConstants.totalPriceText) + makeValueText("\(totalAmount.formattedWithComma())") )
        }
        .padding(.leading, UIConstants.defaultHorizontalPadding)
        .padding(.trailing, UIConstants.defaultHorizontalPadding - 2)
    }
    
    /// 리스트 본문 (각 영수증 카드)
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
    
    /// 영수증 추가 방식 선택 다이얼로그 (카메라, 사진 라이브러리 등)
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

// MARK: - Extension

extension ReceiptView {
    
    /// 영수증 삭제 처리
    private func deleteItems(_ offsets: IndexSet) {
        for index in offsets {
            let deletedReceipt = receipts[index]
            
            // 현재 선택된 이미지와 동일하면 상태 초기화
            if let selectedImage = viewModel.selectedImage,
               let receiptImage = deletedReceipt.imageData,
               selectedImage.pngData() == receiptImage {
                viewModel.resetRecognizedReceipt()
            }
            
            context.delete(deletedReceipt)
        }
        try? context.save()
    }
    
    /// 기본 정보 텍스트 스타일
    private func makeInfoText(_ text: String) -> Text {
        Text(text)
            .font(.mainTextRegular18)
            .foregroundStyle(Color.black)
    }
    
    /// 값 텍스트 스타일
    private func makeValueText(_ text: String) -> Text {
        Text(text)
            .font(.mainTextSemiBold18)
            .foregroundStyle(Color.brown01)
    }
    
    /// 이미지 탭시 전체 보기 액션 연결
    private func listAction(_ receipt: ReceiptModel) -> () -> Void {
        return {
            if let imageData = receipt.imageData {
                viewModel.identifiableImageData = .init(data: imageData)
            }
        }
    }
}

#Preview {
    ReceiptView()
}
