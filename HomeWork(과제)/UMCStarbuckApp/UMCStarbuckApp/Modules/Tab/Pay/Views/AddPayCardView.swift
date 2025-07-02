//
//  AddPayCardView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/1/25.
//

import SwiftUI
import SwiftData

struct AddPayCardView: View {
    // MARK: - Property
    @State var viewModel: AddPayCardViewModel
    @Environment(\.modelContext) var context
    
    // MARK: - Constants
    fileprivate enum AddPayConstants {
        static let leadingPadding: CGFloat = 34
        static let trailingPadding: CGFloat = 32
        static let topPadding: CGFloat = 9
        
        static let topVspacing: CGFloat = 36
        static let middleVspacing: CGFloat = 25
        
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
    }
    
    // MARK: - Init
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: AddPayConstants.defaultVspacing, content: {
            topContents
            middleContents
            Spacer()
            MainButton(color: Color.green01, text: AddPayConstants.bottomTitle, action: {
                print("hello")
            })
        })
        .safeAreaPadding(.top, AddPayConstants.topPadding)
        .safeAreaPadding(.leading, AddPayConstants.leadingPadding)
        .safeAreaPadding(.trailing, AddPayConstants.trailingPadding)
    }
    
    // MARK: - TopContents
    
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
    
    // MARK: - Middle
    private var middleContents: some View {
        VStack(spacing: AddPayConstants.middleVspacing, content: {
            textFieldContents
            addCardImageBtn
        })
    }
    
    private var textFieldContents: some View {
        VStack(spacing: AddPayConstants.defaultVspacing, content: {
            makeTextField(text: $viewModel.cardName, type: .name)
            makeTextField(text: $viewModel.cardNumber, type: .number)
        })
    }
    
    // TODO: - API 이미지 연결
    private var addCardImageBtn: some View {
        Button(action: {
            print("카드 이미지 생성 API")
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: AddPayConstants.buttonCornerRadius)
                    .fill(Color.white01)
                
                VStack(spacing: AddPayConstants.buttonVspacing, content: {
                    Image(.buttonPlus)
                    
                    Text(AddPayConstants.addCardImage)
                        .font(.mainTextMedium16)
                        .foregroundStyle(Color.gray05)
                })
            }
        })
        .frame(height: AddPayConstants.buttonHeight)
    }
}

extension AddPayCardView {
    private func makeTextField(text: Binding<String>, type: PayCardFieldType) -> some View {
        VStack(spacing: AddPayConstants.textFieldDividerSpacing, content: {
            TextField("", text: text, prompt: makePlaceholder(text: type.placeholder))
                .submitLabel(type.submitLabel)
                .keyboardType(type.keyboardType)
                .font(.mainTextBold16)
                .foregroundStyle(Color.black)
                .frame(height: AddPayConstants.textFieldHeight)
            
            Divider()
                .foregroundStyle(Color.gray01)
        })
    }
    
    private func makePlaceholder(text: String) -> Text {
        Text(text)
            .font(.mainTextMedium16)
            .foregroundStyle(Color.black)
    }
    
    // MARK: - SwiftData
}

#Preview {
    AddPayCardView(container: DIContainer())
}
