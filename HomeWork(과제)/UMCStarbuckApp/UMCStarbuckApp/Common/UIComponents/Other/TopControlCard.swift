//
//  TopControlButton.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import SwiftUI

struct TopControlCard: View {
    
    // MARK: - Property
    let type: TopControlType
    let action: (TopControlType) -> Void
    
    // MARK: - Constants
    fileprivate enum TopControlCardConstant {
        static let cornerRadius: CGFloat = 15
        static let spacing: CGFloat = 4
    }
    
    
    // MARK: - Init
    init(type: TopControlType, action: @escaping (TopControlType) -> Void) {
        self.type = type
        self.action = action
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            action(type)
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: TopControlCardConstant.cornerRadius)
                    .fill(Color.white)
                    .otherShadow()
                
                contents
            }
        })
    }
    
    private var contents: some View {
        VStack(spacing: TopControlCardConstant.spacing, content: {
            Image(type.image)
            Text(type.rawValue)
                .font(type.font)
                .foregroundStyle(type.color)
        })
    }
}

#Preview {
    TopControlCard(type: .myMenu, action: {_ in 
        print()
    })
}
