//
//  ContentView.swift
//  5st_Practice
//
//  Created by Apple Coding machine on 4/10/25.
//

import SwiftUI

struct JSONParsingView: View {
    
    var viewModel: JSONParsingViewModel = .init()
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.loadMyProfile { result in
                    switch result {
                    case .success(_):
                        self.showSheet.toggle()
                    case .failure(let error):
                        print("error: \(error)")
                    }
                }
            }, label: {
                Text("json 파일 파싱하기 버튼")
                    .font(.headline)
                    .foregroundStyle(Color.red)
                
            })
            .sheet(isPresented: $showSheet, content: {
                VStack {
                    Capsule(style: .circular)
                        .fill(Color.black)
                        .frame(width: 40, height: 5)
                        .padding(.top, 5)
                    
                    Spacer()
                    
                        if let profile = viewModel.myProfile {
                            Text("닉네임: \(profile.nickname)")
                            Text("취미: \(profile.hobby)")
                            Text("좋아하는 캐릭터: \(profile.favoriteCharacter)")
                            Text("거주지: \(profile.location)")
                        }
                    
                    Spacer()
                    }
                
            })
            .presentationDetents([.medium])
            
            Spacer()
        }
    }
}

#Preview {
    JSONParsingView()
}
