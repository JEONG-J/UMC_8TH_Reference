//
//  BreadDataSource.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/20/25.
//

import Foundation

struct BreadDataSource {
    static let breadItems: [BreadMenuItems] = [
        .init(name: "너티 크루아상", thumbnailImage: .croissants),
        .init(name: "매콤 소시지 불고기", thumbnailImage: .sausage),
        .init(name: "미니 리프 파이", thumbnailImage: .pi),
        .init(name: "뺑 오 쇼콜라", thumbnailImage: .chocolat),
        .init(name: "소시지&올리브 파이", thumbnailImage: .sausagePi)
    ]
}
