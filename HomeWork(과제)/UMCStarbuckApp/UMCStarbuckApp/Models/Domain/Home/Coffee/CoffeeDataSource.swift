//
//  CoffeeDataSource.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/20/25.
//

import Foundation

struct CoffeeDataSource {
    static let detailItems: [CoffeeMenuItem] = [
        .init(
            id: .init(uuidString: "00000000-0000-0000-0000-000000000001")!,
            name: "에스프레소 콘 파나",
            subName: "Espresso Con Panna",
            price: 4100,
            variants: [
                .hot: .init(
                    image: .confana,
                    description: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료"
                )
            ]
        ),
        .init(
            id: .init(uuidString: "00000000-0000-0000-0000-000000000002")!,
            name: "에스프레소 마끼아또",
            subName: "Espresso Macchiato",
            price: 3900,
            variants: [
                .iced: .init(
                    image: .macchiato,
                    description: "신선한 에스프레소 샷에 우유 거품을 살짝 얹은 커피 음료로서, 강렬한 에스프레소의 맛과 우유의 부드러움을 같이 즐길 수 있는 커피 음료"
                )
            ]
        ),
        .init(
            id: .init(uuidString: "00000000-0000-0000-0000-000000000003")!,
            name: "아이스 카페 아메리카노",
            subName: "Iced Caffe Americano",
            price: 4700,
            variants: [
                .iced: .init(
                    image: .americanpCold,
                    description: "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피"
                )
            ]
        ),
        .init(
            id: .init(uuidString: "00000000-0000-0000-0000-000000000004")!,
            name: "카페 아메리카노",
            subName: "Caffe Americano",
            price: 4700,
            variants: [
                .hot: .init(
                    image: .americanoHot,
                    description: "진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피"
                )
            ]
        ),
        .init(
            id: .init(uuidString: "00000000-0000-0000-0000-000000000005")!,
            name: "아이스 카라멜 마끼아또",
            subName: "Iced Caramel Macchiato",
            price: 6100,
            variants: [
                .iced: .init(
                    image: .caramerlCold,
                    description: "향긋한 바닐라 시럽과 시원한 우유에 얼음을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료"
                )
            ]
        ),
        .init(
            id: .init(uuidString: "00000000-0000-0000-0000-000000000006")!,
            name: "카라멜 마끼아또",
            subName: "Caramel Macchiato",
            price: 6100,
            variants: [
                .hot: .init(
                    image: .caramelHot,
                    description: "향긋한 바닐라 시럽과 따뜻한 스팀 밀크 위에 풍성한 우유 거품을 얹고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료"
                )
            ]
        ),
    ]
    
    static let summaryItems: [CoffeeSummaryItem] = [
        .init(
            id: .init(uuidString: "00000000-0000-0000-0000-000000000001")!,
            name: "에스프레소 콘 파나",
            thumbnailImage: .confanaCircle
        ),
        .init(
            id: .init(uuidString: "00000000-0000-0000-0000-000000000002")!,
            name: "에스프레소 마끼아또",
            thumbnailImage: .macchiatoCircle
        ),
        .init(
            id: .init(uuidString: "00000000-0000-0000-0000-000000000003")!,
            name: "아이스 카페 아메리카노",
            thumbnailImage: .americanoIceCircle
        ),
        .init(
            id: .init(uuidString: "00000000-0000-0000-0000-000000000004")!,
            name: "카페 아메리카노",
            thumbnailImage: .americanoHotCircle
        ),
        .init(
            id: .init(uuidString: "00000000-0000-0000-0000-000000000005")!,
            name: "아이스 카라멜 마끼아또",
            thumbnailImage: .macchiatoIceCircle
        ),
        .init(
            id: .init(uuidString: "00000000-0000-0000-0000-000000000006")!,
            name: "카라멜 마끼아또",
            thumbnailImage: .macchiatoHotCircle
        ),
    ]
}
