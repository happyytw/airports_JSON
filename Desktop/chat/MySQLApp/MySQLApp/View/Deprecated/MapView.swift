//
//  MapView.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/11.
//

import SwiftUI
import MapKit

struct MapView: View {
    // MARK: - PROPERTIES
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5315, longitude: 126.9265), latitudinalMeters: 400.0, longitudinalMeters: 400.0) // map view를 만들기 위해서는 @State는 의무적으로 사용해야한다.
    // 왜냐하면 지도는 binding을 사용하여 변화를 감지하기 때문이다. (route tracking, panning, spinning, zooming in, zooming out)
    // 60.0, 60.0은 zoom level
    
    // MARK: - BODY
    
    var body: some View {
        Map(coordinateRegion: $region)
            .overlay(
                NavigationLink(destination: MapView(), label: {
                    HStack {
                        Image(systemName: "mappin.circle")
                            .foregroundColor(Color.white)
                            .imageScale(.large)
                        
                        Text("Locations")
                            .foregroundColor(.accentColor)
                            .fontWeight(.bold)
                    } //: HSTACK
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(
                        Color.black
                            .opacity(0.4)
                            .cornerRadius(8)
                    )
                }) //: NAVIGATION
                    .padding(12)
                , alignment: .topTrailing
                )
            .frame(height: 256)
            .cornerRadius(12)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
