//
//  StickyHeader.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import SwiftUI

struct StickyHeader<Content: View, Segment: View, SubSegment: View>: View {
    
    @Binding var headerOffset: (CGFloat, CGFloat)
    let stickyModel: StickyModel
    
    let proxyName: String = "SCROLL"
    let stickyHeaderDefaultMargins: CGFloat = 10
    let stickyRatio: Double = 0.05
    let sticyHeaderAnimation: TimeInterval = 0.4
    let pinnedSpacing: CGFloat = 6
    
    let content: () -> Content
    let segment: (() -> Segment)?
    let subSegment: (() -> SubSegment)?
    
    init(
        headerOffset: Binding<(CGFloat, CGFloat)>,
        stickyModel: StickyModel,
        @ViewBuilder content: @escaping () -> Content,
        segment: (() -> Segment)? = nil,
        subSegment: (() -> SubSegment)? = nil
    ) {
        self._headerOffset = headerOffset
        self.stickyModel = stickyModel
        self.content = content
        self.segment = segment
        self.subSegment = subSegment
    }
    
    var body: some View {
        ScrollView(.vertical, content: {
            VStack(spacing: .zero, content: {
                headerView()
                middleContents
            })
            .padding(.bottom, UIConstants.defaultscrollBottomPadding)
        })
        .ignoresSafeArea()
        .background(stickyModel.background)
        .coordinateSpace(name: proxyName)
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named(proxyName)).minY
            let size = proxy.size
            let height = max(.zero, size.height + minY)
            
            Rectangle()
                .fill(stickyModel.background)
                .frame(width: size.width, height: height, alignment: .top)
                .offset(y: -minY)
        }
        .frame(height: stickyModel.stickyHeaderHeight)
    }
    
    private var middleContents: some View {
        LazyVStack(alignment: .leading, spacing: stickyModel.lazySpacing, pinnedViews: [.sectionHeaders], content: {
            Section(content: {
                content()
            }, header: {
                pinnedHeaderView()
                    .modifier(OffsetModifier(offset: $headerOffset.0, returnromStart: false))
                    .modifier(OffsetModifier(offset: $headerOffset.1))
            })
        })
        .contentMargins(.top, stickyHeaderDefaultMargins)
    }
    
    @ViewBuilder
    private func pinnedHeaderView() -> some View {
        let threshold = -(getScreenSize().height * stickyRatio)
        VStack(alignment: .leading, spacing: pinnedSpacing, content: {
            pinnedHeaderTitle(threshold: threshold)
            
            if let segment = segment {
                segment()
            }
            
            if let subSegment = subSegment {
                subSegment()
            }
        })
        .background(stickyModel.background)
    }
    
    private func pinnedHeaderTitle(threshold: Double) -> some View {
        Text(stickyModel.pinnedHeaderText)
            .font(headerOffset.0 < threshold ? .mainTextSemiBold18 : .mainTextBold24)
            .foregroundStyle(Color.black03)
            .padding(headerOffset.0 < threshold ? .zero : (stickyModel.titlePadding ?? 0))
            .frame(maxWidth: .infinity, alignment: headerOffset.0 < threshold ? .center : .leading)
            .frame(height: stickyModel.affterStickyPinnedHeight, alignment: .bottom)
            .safeAreaPadding(.bottom, headerOffset.0 < threshold ? stickyHeaderDefaultMargins : .zero)
            .background(stickyModel.background)
            .animation(.easeInOut(duration: sticyHeaderAnimation), value: headerOffset.0)
            .stickyShadow(isActive: headerOffset.0 < threshold)
    }
}
