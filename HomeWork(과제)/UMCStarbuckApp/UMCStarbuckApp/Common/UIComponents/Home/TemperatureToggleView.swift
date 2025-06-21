//
//  TemperatureToggleView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

struct TemperatureToggleView: View {
    
    // MARK: - Property
    @Binding var selected: CoffeeTemperature
    let available: [CoffeeTemperature]
    
    @Namespace private var animation
    
    // MARK: - Constants
    fileprivate enum TemperatureToggleConstants {
        static let buttonHeight: CGFloat = 36
        static let cornerRadius: CGFloat = 999
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: .zero, content: {
            ForEach(available, id: \.self) { temp in
                toogleButton(temp)
            }
        })
        .background {
            RoundedRectangle(cornerRadius: TemperatureToggleConstants.cornerRadius)
                .fill(Color.gray07)
        }
    }
    
    private func toogleButton(_ temp: CoffeeTemperature) -> some View {
        Button(action: {
            withAnimation {
                selected = temp
            }
        }, label: {
            Text(temp.rawValue)
                .font(.mainTextSemiBold18)
                .foregroundStyle(selected == temp ? selectedColor(for: temp) : .gray02)
                .frame(maxWidth: .infinity, minHeight: TemperatureToggleConstants.buttonHeight)
                .background {
                    ZStack {
                        if selected == temp {
                            Capsule()
                                .fill(Color.white)
                                .shadow01()
                                .matchedGeometryEffect(id: "underline", in: animation)
                        }
                    }
                }
        })
    }
    
    private func selectedColor(for temp: CoffeeTemperature) -> Color {
        switch temp {
        case .hot:
            return .red01
        case .iced:
            return .blue01
        }
    }
}

#Preview {
    TemperatureToggleView(selected: .constant(.hot), available: [
        .hot, .iced
    ])
}
