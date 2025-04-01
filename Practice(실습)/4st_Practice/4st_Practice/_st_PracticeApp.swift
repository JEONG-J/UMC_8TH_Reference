//
//  _st_PracticeApp.swift
//  4st_Practice
//
//  Created by Apple Coding machine on 4/1/25.
//

import SwiftUI
import SwiftData

@main
struct _st_PracticeApp: App {
    var body: some Scene {
        WindowGroup {
            ReceiptsView()
        }
        .modelContainer(for: ReceiptsModel.self)
    }
}
