//
//  LocationInputView.swift
//  AziTeam
//
//  Created by mobicom on 2023/10/31.
//

import SwiftUI
import MapKit

struct AnnotatedItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct LocationInputView: View {
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var selectedLocation: AnnotatedItem?
    @State private var showingCircle: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                Text("위치 정보 입력하기")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(.bottom, 30)
                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: Binding.constant(MapUserTrackingMode.follow), annotationItems: selectedLocation != nil ? [selectedLocation!] : []) { item in
                    MapMarker(coordinate: item.coordinate, tint: .blue)
                }
                .cornerRadius(radius: 40)
                .overlay(
                    Circle().stroke(Color.blue, lineWidth: 2).frame(width: 100, height: 100).opacity(showingCircle ? 1 : 0)
                )
                .onTapGesture {
                    let location = region.center
                    selectedLocation = AnnotatedItem(coordinate: location)
                    showingCircle = true
                }
                
            }
            .frame(width: 350, height: 500)
            
            
        }
        .navigationBarHidden(true)
    }
}

struct LocationInputView_Previews: PreviewProvider {
    static var previews: some View {
        LocationInputView()
    }
}
