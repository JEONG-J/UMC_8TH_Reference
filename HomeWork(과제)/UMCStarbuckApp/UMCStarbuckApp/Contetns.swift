//
//  Contetns.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import SwiftUI

struct Contetns: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                // 폰트 체크 하기
                UIFont.familyNames.sorted().forEach { familyName in
                    print("*** \(familyName) ***")
                    UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
                        print("\(fontName)")
                    }
                    print("---------------------")
                }
            }
    }
}

#Preview {
    Contetns()
}
