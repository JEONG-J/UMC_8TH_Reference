//
//  FormTextField.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/18/25.
//

import SwiftUI

/// 다양한 FormFieldType에 대응 가능한 재사용 가능한 커스텀 텍스트 필드 컴포넌트
/// (로그인, 회원가입, 프로필 수정 등에서 사용 가능)
struct FormTextField<T: FormFieldType & Hashable>: View {
    
    // MARK: - Property
    
    /// 현재 필드의 타입 (예: .id, .password 등)
    let fieldType: T
    
    /// 외부에서 제어하는 포커스 상태
    let focusedField: FocusState<T?>.Binding
    
    /// 현재 뷰에 해당하는 필드 (포커스 비교용)
    let currentField: T
    
    /// 텍스트 입력 바인딩
    @Binding var text: String
    
    // MARK: - Init
    
    /// 사용자 정의 초기화 함수 (Binding 타입을 @Binding 변수로 연결)
    init(
        fieldType: T,
        focusedField: FocusState<T?>.Binding,
        currentField: T,
        text: Binding<String>
    ) {
        self.fieldType = fieldType
        self.focusedField = focusedField
        self.currentField = currentField
        self._text = text
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: FormTextFieldConstants.stackSpacing, content: {
            textFieldLabel      // 라벨: 포커스되면 위로 올라가는 텍스트
            dividerTextField    // 입력 필드와 하단 구분선
        })
    }
    
    // MARK: - TextFieldContents

    /// 필드 라벨 뷰
    /// 입력 중이거나 텍스트가 있을 경우 위로 떠오름 (플로팅 라벨 효과)
    private var textFieldLabel: some View {
        Text(fieldType.title)
            .font(fieldType.placeholderFont)
            .foregroundStyle(fieldType.placeholderTextColor)
            .offset(y: (focusedField.wrappedValue == currentField || !text.isEmpty) ? .zero : FormTextFieldConstants.offSetValue)
            .animation(.easeInOut(duration: FormTextFieldConstants.animationDuration), value: focusedField.wrappedValue == currentField || !text.isEmpty)
    }
    
    /// 텍스트 필드와 구분선 전체를 감싸는 뷰
    private var dividerTextField: some View {
        VStack(alignment: .leading, spacing: .zero, content: {
            mainTextField    // TextField 또는 SecureField
            bottomDivider    // 하단 선
        })
    }
    
    /// SecureField 또는 TextField 생성 뷰
    @ViewBuilder
    private var mainTextField: some View {
        Group {
            if fieldType.isSecure {
                SecureField("", text: $text)
                    .focused(focusedField, equals: currentField)
                    .submitLabel(fieldType.submitLabel)
            } else {
                TextField("", text: $text)
                    .focused(focusedField, equals: currentField)
                    .submitLabel(fieldType.submitLabel)
                    .keyboardType(fieldType.keyboardType)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            }
        }
    }
    
    /// 입력 필드 하단의 구분선
    /// 포커스 여부에 따라 색상이 초록색/회색으로 전환됨
    private var bottomDivider: some View {
        Divider()
            .background(focusedField.wrappedValue == currentField ? Color.green01 : Color.gray00)
            .frame(height: FormTextFieldConstants.dividerHeight)
    }
}

/// FormTextField 내부에서 사용하는 상수 정의용 enum
fileprivate enum FormTextFieldConstants {
    static let stackSpacing: CGFloat = 4           // 전체 VStack 간격
    static let offSetValue: CGFloat = 20           // 포커스 없을 때 라벨 아래로 내리는 위치
    static let dividerHeight: CGFloat = 0.7        // 하단 구분선 높이
    static let animationDuration: TimeInterval = 0.2        // 애니메이션 시간 초
}
