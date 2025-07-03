//
//  AddPayCardView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/1/25.
//

import SwiftUI
import SwiftData

/// 카드 등록 화면
struct AddPayCardView: View {
    // MARK: - Property

    /// 카드 등록을 위한 ViewModel
    @State var viewModel: AddPayCardViewModel

    /// 현재 뷰를 닫기 위한 환경 변수
    @Environment(\.dismiss) var dismiss

    /// SwiftData 저장을 위한 context
    @Environment(\.modelContext) var context

    // MARK: - Constants

    /// UI 레이아웃 상수를 모아놓은 enum
    fileprivate enum AddPayConstants {
        static let leadingPadding: CGFloat = 34
        static let trailingPadding: CGFloat = 32
        static let topPadding: CGFloat = 9
        
        static let topVspacing: CGFloat = 36
        static let middleVspacing: CGFloat = 25
        static let imageVspacing: CGFloat = 3
        static let imageHspacing: CGFloat = 8
        
        static let defaultVspacing: CGFloat = 48
        static let textFieldHeight: CGFloat = 28
        static let textFieldDividerSpacing: CGFloat = 4
        
        static let buttonCornerRadius: CGFloat = 10
        static let buttonVspacing: CGFloat = 15
        static let buttonHeight: CGFloat = 183
        
        static let capsuleWidth: CGFloat = 70
        static let capsuleHeight: CGFloat = 4
        
        static let topTitle: String = "카드 등록"
        static let addCardImage: String = "카드 이미지 생성하기"
        static let bottomTitle: String = "카드 등록하기"
        static let addImageText: String = "이미지 생성 중.."
    }

    // MARK: - Init

    /// DIContainer를 통해 ViewModel을 초기화
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: AddPayConstants.defaultVspacing, content: {
            topContents
            middleContents
            Spacer()
            // 등록 버튼
            MainButton(color: Color.green01, text: AddPayConstants.bottomTitle, action: {
                saveCard()
                dismiss()
            })
        })
        .safeAreaPadding(.top, AddPayConstants.topPadding)
        .safeAreaPadding(.leading, AddPayConstants.leadingPadding)
        .safeAreaPadding(.trailing, AddPayConstants.trailingPadding)
    }

    // MARK: - 상단 캡슐 및 타이틀
    private var topContents: some View {
        VStack(spacing: AddPayConstants.topVspacing, content: {
            Capsule()
                .fill(Color.gray04)
                .frame(width: AddPayConstants.capsuleWidth, height: AddPayConstants.capsuleHeight)

            Text(AddPayConstants.topTitle)
                .font(.mainTextBold24)
                .foregroundStyle(Color.black03)
        })
    }

    // MARK: - 카드 정보 입력 영역
    private var middleContents: some View {
        VStack(spacing: AddPayConstants.middleVspacing, content: {
            textFieldContents
            cardImageBranch
        })
    }

    /// 카드 이름 및 번호 입력 필드
    private var textFieldContents: some View {
        VStack(spacing: AddPayConstants.defaultVspacing, content: {
            makeTextField(text: $viewModel.cardName, type: .name)
            makeTextField(text: $viewModel.cardNumber, type: .number)
        })
    }

    /// 카드 이미지 등록/생성 분기 처리
    @ViewBuilder
    private var cardImageBranch: some View {
        if let uiImage = viewModel.generatedImage {
            completedCardImage(uiImage: uiImage)
        } else {
            addCardImageBtn
        }
    }

    /// 생성 완료된 이미지 표시
    private func completedCardImage(uiImage: UIImage) -> some View {
        Image(uiImage: uiImage)
            .resizable()
            .frame(height: AddPayConstants.buttonHeight)
            .clipShape(RoundedRectangle(cornerRadius: AddPayConstants.buttonCornerRadius))
    }

    /// 이미지 생성 버튼
    private var addCardImageBtn: some View {
        Button(action: {
            viewModel.generateImageAction()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: AddPayConstants.buttonCornerRadius)
                    .fill(Color.white01)

                imageBtnBranch
            }
        })
        .frame(height: AddPayConstants.buttonHeight)
        .disabled(viewModel.isGenerating)
    }

    /// 생성 중이면 ProgressView, 아니면 버튼 텍스트
    @ViewBuilder
    private var imageBtnBranch: some View {
        if viewModel.isGenerating {
            imageLoadingProgress
        } else {
            addCardImage
        }
    }

    /// 이미지 생성 버튼 텍스트
    private var addCardImage: some View {
        VStack(spacing: AddPayConstants.buttonVspacing, content: {
            Image(.buttonPlus)
            Text(AddPayConstants.addCardImage)
                .font(.mainTextMedium16)
                .foregroundStyle(Color.gray05)
        })
    }

    /// 이미지 생성 진행률 표시
    private var imageLoadingProgress: some View {
        VStack(spacing: AddPayConstants.imageVspacing, content: {
            HStack(spacing: AddPayConstants.imageHspacing, content: {
                ProgressView()
                    .controlSize(.mini)

                Text(AddPayConstants.addImageText)
                    .font(.mainTextRegular13)
            })
            .foregroundStyle(Color.gray03)

            Text(String(format: "%.1f%%", viewModel.progressPercentage))
                .font(.mainTextMedium16)
                .foregroundStyle(Color.gray05)
        })
    }
}

// MARK: - 텍스트 필드 및 저장 로직 확장
extension AddPayCardView {
    /// 카드 이름/번호 제한 설정된 텍스트 필드
    private func makeTextField(text: Binding<String>, type: PayCardFieldType) -> some View {
        let limitedBinding = Binding<String>(
            get: { text.wrappedValue },
            set: { newValue in
                let maxCount = (type == .name) ? viewModel.maxCardNameCount : viewModel.maxCardNumberCount
                if newValue.count <= maxCount {
                    text.wrappedValue = String(newValue.prefix(maxCount))
                }
            }
        )

        return VStack(spacing: AddPayConstants.textFieldDividerSpacing, content: {
            TextField("", text: limitedBinding, prompt: makePlaceholder(text: type.placeholder))
                .submitLabel(type.submitLabel)
                .keyboardType(type.keyboardType)
                .font(.mainTextBold16)
                .foregroundStyle(Color.black)
                .frame(height: AddPayConstants.textFieldHeight)

            Divider()
                .foregroundStyle(Color.gray01)
        })
    }

    /// Placeholder 스타일
    private func makePlaceholder(text: String) -> Text {
        Text(text)
            .font(.mainTextMedium16)
            .foregroundStyle(Color.black)
    }

    // MARK: - SwiftData 저장 로직

    /// 카드 정보를 저장하는 메서드
    public func saveCard() {
        let card = viewModel.saveCard()
        context.insert(card)

        do {
            try context.save()
            print("카드 저장 완료")
        } catch {
            print("카드 저장 실패: \(error)")
        }
    }
}

#Preview {
    AddPayCardView(container: DIContainer())
}
