import SwiftUI
import MapKit

struct LocationInputView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.88371, longitude: 127.73947),
        span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
    )
    
    var body: some View {
        VStack {
            Text("위치 정보 입력하기")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding(.bottom, 30)
            
            Map(coordinateRegion: $region, showsUserLocation: true)
                .onAppear(perform: {
                    let manager = CLLocationManager()
                    manager.requestWhenInUseAuthorization()
                    manager.startUpdatingLocation()
                }
                )
        }
        .frame(width: 350, height: 500)
        
    }
}

struct LocationInputView_Previews: PreviewProvider {
    static var previews: some View {
        LocationInputView()
    }
}
