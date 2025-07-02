//
//  StickyHeader.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import SwiftUI

/// 상단에 고정되는 스티키 헤더를 포함한 커스텀 ScrollView 구성 뷰입니다.
/// - `Content`: 본문 콘텐츠 뷰
/// - `Segment`: 메인 세그먼트 뷰 (선택적)
/// - `SubSegment`: 서브 세그먼트 뷰 (선택적)
struct StickyHeader<Content: View, Segment: View, SubSegment: View>: View {
    
    // MARK: - Property
    
    /// 헤더 스크롤 오프셋 상태
    /// (0) 헤더의 현재 위치 (1) 타이틀 고정 영역 기준 오프셋
    @Binding var headerOffset: (CGFloat, CGFloat)
    
    /// 헤더 레이아웃 및 스타일을 정의한 모델
    let stickyModel: StickyModel
    
    /// ScrollView 내부 좌표 공간 이름 (GeometryReader 추적용)
    let proxyName: String = "SCROLL"
    
    /// 기본 마진, 헤더 크기 계산에 사용
    let stickyHeaderDefaultMargins: CGFloat = 10
    
    /// 스크롤 기준 임계값 비율 (뷰 높이에 비례)
    let stickyRatio: Double = 0.05
    
    /// 타이틀 애니메이션 지속 시간
    let sticyHeaderAnimation: TimeInterval = 0.4
    
    /// 고정 타이틀과 세그먼트 사이 간격
    let pinnedSpacing: CGFloat = 6
    
    /// 본문 콘텐츠 뷰 빌더
    let content: () -> Content
    
    /// 선택적 메인 세그먼트 뷰 빌더
    let segment: (() -> Segment)?
    
    /// 선택적 서브 세그먼트 뷰 빌더
    let subSegment: (() -> SubSegment)?
    
    // MARK: - Init
    
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
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical, content: {
            VStack(spacing: .zero, content: {
                headerView()        // 상단 배경 확장형 헤더
                middleContents      // 스크롤 가능한 본문 콘텐츠 + 고정 헤더
            })
            .padding(.bottom, UIConstants.defaultscrollBottomPadding)
        })
        .ignoresSafeArea() // 헤더가 상단 안전영역을 침범할 수 있도록 처리
        .background(stickyModel.background)
        .coordinateSpace(name: proxyName) // GeometryReader에서 사용할 좌표 공간 설정
    }
    
    /// 확장형 상단 헤더 (스크롤에 따라 높이 변화)
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
    
    /// 본문 콘텐츠 + 고정 헤더 영역
    private var middleContents: some View {
        LazyVStack(
            alignment: .leading,
            spacing: stickyModel.lazySpacing,
            pinnedViews: [.sectionHeaders], // 스크롤 시 헤더 고정
            content: {
                Section(content: {
                    content()
                }, header: {
                    pinnedHeaderView()
                        .modifier(OffsetModifier(offset: $headerOffset.0, returnromStart: false))
                        .modifier(OffsetModifier(offset: $headerOffset.1))
                })
            }
        )
        .contentMargins(.top, stickyHeaderDefaultMargins)
    }
    
    /// 고정되는 상단 타이틀 + 세그먼트 뷰 구성
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
    
    /// 고정 타이틀 텍스트의 크기, 정렬, 패딩 등을 스크롤 오프셋에 따라 변경
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
