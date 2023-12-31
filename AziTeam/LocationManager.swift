//
//  LocationManager.swift
//  AziTeam
//
//  Created by 길지훈 on 2023/11/02.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    @Published var mapView: MKMapView = .init()
    
    // 지도의 움직임 여부 저장 프로퍼티
    @Published var isChanging: Bool = false
    
    // 현재 위치의 도로명 주소를 저장하는 프로퍼티
    @Published var currentPlace: String = ""
    
    private var manager: CLLocationManager = .init()
    
    // 현재 위치 저장 프로퍼티
    private var currentGeoPoint: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        
        self.configureLocationManager()
    }
    
    // 사용자의 위치 권한 여부를 확인하고 요청하거나 현재 위치 Mapview를 이동하는 메서드
    func configureLocationManager() {
        mapView.delegate = self
        manager.delegate = self
        
        let status = manager.authorizationStatus
        
        if status == .notDetermined {
            manager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            
            // 사용자의 위치 확인 가능하게
            mapView.showsUserLocation = true
        }
    }
    
    // MapView에서 화면이 이동 시, 호출되는 메서드
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        DispatchQueue.main.async {
            self.isChanging = false
        }
    }
    
    // 특정 위치로 MapView의 Focus를 이동하는 메서드
    func mapViewFocusChange() {
        print("[SUCCESS] Map Focus Changed")
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: self.currentGeoPoint ?? CLLocationCoordinate2D(latitude: 36.351832479773925, longitude: 127.30154592425923), span: span)
        mapView.setRegion(region, animated: true)
    }
    
    // 사용자에게 위치 권한이 변경되면 호출되는 메서드 (LocationManager 인스턴스가 생성될 때도 호출)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            guard let location = manager.location else {
                print("[ERROR] No location")
                return
            }
            // 현재 위치 저장
            self.currentGeoPoint = location.coordinate
            // 현재 위치로 MapView를 이동
            self.mapViewFocusChange()
            self.convertLocationToAddress(location: location)
        }
    }
    
    // 사용자 위치가 변경되면 호출되는 메서드
    ///  startUpdatingLocation 메서드 혹은 requestLocation 메서드를 호출했을 때만 이 메서드가 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations Locations: [CLLocation]) {
        print("[SUCCESS] Did Update Locations")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func convertLocationToAddress(location: CLLocation) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            
            self.currentPlace = "\(placemark.country ?? "") \(placemark.locality ?? "") \(placemark.name ?? "")"
        }
    }
}
