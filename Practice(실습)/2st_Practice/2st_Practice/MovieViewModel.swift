//
//  MovieViewModel.swift
//  2st_Practice
//
//  Created by Apple Coding machine on 3/16/25.
//

import Foundation
import SwiftUI

@Observable
class MovieViewModel {
    
    var currentIndex: Int = 0
    
    let movieModel: [MovieModel] = [
        .init(movieImage: .init(.mickey), movieName: "미키", movieLike: 972, movieReserCount: 30.8),
        .init(movieImage: .init(.toystory), movieName: "토이스토리", movieLike: 999, movieReserCount: 99.8),
        .init(movieImage: .init(.brutalis), movieName: "브루탈리스트", movieLike: 302, movieReserCount: 24.8),
        .init(movieImage: .init(.snowWhite), movieName: "백설공주", movieLike: 302, movieReserCount: 3.8),
        .init(movieImage: .init(.whiplash), movieName: "위플래시", movieLike: 604, movieReserCount: 62.2),
        .init(movieImage: .init(.conclave), movieName: "콘클라베", movieLike: 392, movieReserCount: 43.9),
        .init(movieImage: .init(.theFall), movieName: "더폴", movieLike: 30, movieReserCount: 2.1)
    ]
    
    /// 이전 영화로 돌아가기, 단, 첫 번째 영화일 경우 마지막 영화로 전환
    public func previousMovie() {
        currentIndex = (currentIndex - 1 + movieModel.count) % movieModel.count
    }
    
    /// 오른쪽 버튼을 눌렀을 때 다음 영화로 이동하는 함수
    public func nextMovie() {
        currentIndex = (currentIndex + 1) % movieModel.count
    }
}
