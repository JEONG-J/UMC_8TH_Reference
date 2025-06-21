//
//  BannerView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

struct BannerView: View {
    
    let image: ImageResource
    
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    BannerView(image: .americanoHot)
}
