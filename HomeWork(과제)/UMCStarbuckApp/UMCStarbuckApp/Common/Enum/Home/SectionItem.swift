//
//  SectionItem.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/20/25.
//

import Foundation

enum HomeContentItem: Identifiable {
    case banner(BannerItem)
    case section(HomeSection)

    var id: UUID {
        switch self {
        case .banner(let item):
            return item.id
        case .section(let section):
            return section.id
        }
    }
}

enum HomeSectionType {
    case coffee, whatsNew, dessert
}
