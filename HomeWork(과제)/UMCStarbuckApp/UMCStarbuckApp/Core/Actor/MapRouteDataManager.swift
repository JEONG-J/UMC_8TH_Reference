//
//  MapRouteDataManager.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/2/25.
//

import Foundation
import MapKit

/// 지도 경로 데이터를 관리하는 Actor 클래스입니다.
/// MKPolyline(경로 선)을 안전하게 저장하고 접근할 수 있도록 도와줍니다.
/// Swift Concurrency 환경에서 thread-safe하게 동작합니다.
actor MapRouteDataManager {
    
    /// 현재 저장된 경로(MKPolyline)
    private var polyline: MKPolyline?
    
    /// 새로운 경로를 설정합니다.
    /// - Parameter newPolyline: 새롭게 설정할 MKPolyline 객체
    func setPolyline(_ newPolyline: MKPolyline?) {
        self.polyline = newPolyline
    }
    
    /// 현재 저장된 경로를 반환합니다.
    /// - Returns: MKPolyline 객체 또는 nil
    func getPolyline() -> MKPolyline? {
        return polyline
    }
    
    /// 저장된 경로 데이터를 초기화합니다.
    func clear() {
        polyline = nil
    }
}
