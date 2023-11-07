import SwiftUI
import MapKit

struct MapViewCoordinator: UIViewRepresentable {
    @ObservedObject var locationManager: LocationManager
    
    func makeUIView(context: Context) -> some UIView {
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct LocationInputView: View {
    
    @ObservedObject var locationManager = LocationManager() // LocationManager 인스턴스 생성
    
    var body: some View {
        VStack {
            Text("위치 정보 입력하기")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding(.bottom, 30)
            MapViewCoordinator(locationManager: locationManager) // MapView를 표시
                .onAppear {
                    locationManager.configureLocationManager()
                }
            
        }
        .navigationBarBackButtonHidden()
        .frame(width: 350, height: 500)
        
    }
}

struct LocationInputView_Previews: PreviewProvider {
    static var previews: some View {
        LocationInputView()
    }
}

//Map(coordinateRegion: $region,
//    interactionModes: MapInteractionModes.all,
//    showsUserLocation: true,
//    userTrackingMode: $tracking
//)
//.onAppear(perform: {
//    let manager = CLLocationManager()
//    manager.requestWhenInUseAuthorization()
//    manager.startUpdatingLocation()
//}
//)
