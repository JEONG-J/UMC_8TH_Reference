//
//  HomeSection.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/20/25.
//

import Foundation

struct HomeSection: Identifiable {
    let id = UUID()
    let title: String
    let items: [any Identifiable]
    let contentType: HomeSectionType
}
