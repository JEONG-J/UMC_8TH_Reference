//
//  NavigationRoutingView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import SwiftUI

struct NavigationRoutingView: View {
    
    @EnvironmentObject var container: DIContainer
    @State var destination: NavigationDestination
    
    var body: some View {
        Group {
            switch destination {
            case .signUp:
                SignUpView()
            case .coffeeDetail(let id):
                DetailCoffeeView(coffeeId: id)
            case .receiptView:
                ReceiptView()
            case .findStoreView:
                FindStoreView(container: container)
            }
        }
        .environmentObject(container)
    }
}
