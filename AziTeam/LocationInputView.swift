import SwiftUI
import MapKit

struct LocationInputView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 36.351832479773925, longitude: 127.30154592425923),
        span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
    )

    @State var tracking: MapUserTrackingMode = .follow
    
    var body: some View {
        VStack {
            Text("위치 정보 입력하기")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding(.bottom, 30)
            
            Map(coordinateRegion: $region,
                interactionModes: MapInteractionModes.all,
                showsUserLocation: true,
                userTrackingMode: $tracking
                )
                .onAppear(perform: {
                    let manager = CLLocationManager()
                    manager.requestWhenInUseAuthorization()
                    manager.startUpdatingLocation()
                }
                )
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
