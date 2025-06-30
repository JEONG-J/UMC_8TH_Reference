//
//  LocationManager.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/25/25.
//

import Foundation
import CoreLocation
import MapKit

@Observable
class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    // MARK: - CLLocationManager
    let locationManager = CLLocationManager()
    
    // MARK: - Published Properties
    var currentLocation: CLLocation?
    var currentHeading: CLHeading?
    
    var currentSpeed: CLLocationSpeed = 0
    var currentDirection: CLLocationDirection = 0
    
    var authorizationStatus: CLAuthorizationStatus = .authorizedAlways
    
    var didEnterGeofence: Bool = false
    var didExitGeofence: Bool = false
    
    // MARK: - Init
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.headingFilter = kCLHeadingFilterNone
        
        requestAuthorization()
        startUpdatingLocation()
        startUpdatingHeading()
    }
    
    // MARK: - 권한 요청
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    // MARK: - 위치 추적
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - 방향 추적
    func startUpdatingHeading() {
        locationManager.startUpdatingHeading()
    }
    
    func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }
    
    // MARK: - Significant Location Change
    func startMonitoringSignificantLocationChanges() {
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func stopMonitoringSignificantLocationChanges() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    // MARK: - 방문 감지
    func startMonitoringVisits() {
        locationManager.startMonitoringVisits()
    }
    
    // MARK: - 지오펜싱
    func startMonitoringGeofence(center: CLLocationCoordinate2D, radius: CLLocationDistance) {
        Task {
            let monitor = await CLMonitor("my_custom_monitor")
            
            let condition = CLMonitor.CircularGeographicCondition(center: center, radius: radius)
            await monitor.add(condition, identifier: "stay_within_200_meters")
            
            for try await event in await monitor.events {
                if event.state == .satisfied {
                    print("지오펜스 안에 들어왔습니다!")
                } else {
                    print("지오펜스 밖으로 나갔습니다!")
                }
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    // 권한 변경 감지
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    // 위치 업데이트 감지 (기본 위치 추적 + Significant Change)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let latest = locations.last {
            DispatchQueue.main.async {
                self.currentLocation = latest
                self.currentSpeed = max(latest.speed, 0)
            }
        }
    }
    
    // 방향 감지
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        DispatchQueue.main.async {
            self.currentHeading = newHeading
            self.currentDirection = newHeading.trueHeading > 0 ? newHeading.trueHeading : newHeading.magneticHeading
        }
    }
    
    // 방문 감지 (visit monitoring)
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        print("방문 감지됨 - 좌표: \(visit.coordinate), 도착: \(visit.arrivalDate), 출발: \(visit.departureDate)")
    }
    
    // 지오펜싱: 진입
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        DispatchQueue.main.async {
            self.didEnterGeofence = true
            self.didExitGeofence = false
        }
    }
    
    // 지오펜싱: 이탈
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        DispatchQueue.main.async {
            self.didEnterGeofence = false
            self.didExitGeofence = true
        }
    }
    
    // 오류 처리
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            print("일시적인 위치 오류: 다시 시도 중…")
            return
        }
        
        print("위치 오류: \(error.localizedDescription)")
    }
}

extension CLLocation {
    func distanceKilometers(other: CLLocation) -> Double {
        return self.distance(from: other) / 1000
    }
}

extension LocationManager {
    func reverseGeocodeCurrentLocatoin(completion: @escaping (String?) -> Void) {
        guard let currentLocatoin = self.currentLocation else {
            print("현재 위치 없음!")
            completion(nil)
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currentLocatoin) { placemarks, error in
            if let error = error {
                print("역지오코딩: \(error.localizedDescription)")
                completion(nil)
            }
            
            guard let placemark = placemarks?.first else {
                print("주소 정보를 찾을 수 없습니다!")
                completion(nil)
                return
            }
            
            var address = ""
            if let region = placemark.administrativeArea { address += region + " " }
            if let city = placemark.locality { address += city + " " }
            if let subLocality = placemark.subLocality { address += subLocality + " " }
            if let street = placemark.thoroughfare { address += street + " " }
            if let number = placemark.subThoroughfare { address += number }
            
            print("현재 위치 주소: \(address)")
            completion(address)
        }
    }
}
