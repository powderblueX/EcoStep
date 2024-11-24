//
//  MapView.swift
//  EcoStep
//
//  Created by admin on 2024/11/19.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // 旧金山坐标
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @State private var trackingMode: MapUserTrackingMode = .follow
    @State private var walkingPath: [Location] = [
        Location(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)), // 起点
        Location(coordinate: CLLocationCoordinate2D(latitude: 37.7849, longitude: -122.4294))  // 终点
    ]
    
    @State private var cyclingPath: [Location] = [
        Location(coordinate: CLLocationCoordinate2D(latitude: 37.7649, longitude: -122.4194)), // 起点
        Location(coordinate: CLLocationCoordinate2D(latitude: 37.7549, longitude: -122.4294))  // 终点
    ]
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $trackingMode,
                annotationItems: walkingPath + cyclingPath) { location in
                    MapPin(coordinate: location.coordinate, tint: .red)
            }
            .edgesIgnoringSafeArea(.all)
            
            HStack {
                Button("显示步行路径") {
                    // 设置步行路径的标注
                    walkingPath = [
                        Location(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)),
                        Location(coordinate: CLLocationCoordinate2D(latitude: 37.7849, longitude: -122.4294))
                    ]
                }
                .padding()
                
                Button("显示骑行路径") {
                    // 设置骑行路径的标注
                    cyclingPath = [
                        Location(coordinate: CLLocationCoordinate2D(latitude: 37.7649, longitude: -122.4194)),
                        Location(coordinate: CLLocationCoordinate2D(latitude: 37.7549, longitude: -122.4294))
                    ]
                }
                .padding()
            }
        }
    }
}

#Preview {
    MapView()
}
