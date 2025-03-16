//
//  MovieCard.swift
//  2st_Practice
//
//  Created by Apple Coding machine on 3/16/25.
//

import SwiftUI

struct MovieCard: View {
    
    let movieInfo: MovieModel
    
    init(movieInfo: MovieModel) {
        self.movieInfo = movieInfo
    }
    
    var body: some View {
        VStack(spacing: 5) {
            movieInfo.movieImage
            
            Text(movieInfo.movieName)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.black)
            
            HStack {
                movieLike
                
                Spacer()
                
                Text("예매율 \(String(format: "%.1f", movieInfo.movieReserCount))%")
                    .font(.system(size: 9, weight: .regular))
                    .foregroundStyle(Color.black)
            }
        }
        
        /* 상위 뷰의 프레임을 꼭 넣어주세요! 피그마에 보시면 fixed로 고정되어 있는게 보이실겁니다.*/
        /* HStack 내부의 Spacer()로 부모 뷰의 사이즈에 영향을 받게됩니다.*/
        .frame(width: 120, height: 216)
    }
    
    /// 하단 영화 좋아요
    private var movieLike: some View {
        HStack(spacing: 6) {
            Image(systemName: "heart.fill")
                .foregroundStyle(Color.red)
                .frame(width: 15, height: 14)
            
            Text("\(movieInfo.movieLike)")
                .font(.system(size: 9, weight: .regular))
                .foregroundStyle(Color.black)
        }
    }
}

#Preview {
    MovieCard(movieInfo:  .init(movieImage: .init(.mickey), movieName: "미키", movieLike: 972, movieReserCount: 30.8))
}
