//
//  MapView.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 53.5461, longitude: -113.4938), // Edmonton
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
        }
        .customNavigationBar(
            config: NavBarConfig(
                title: Constants.location,
                font: .system(size: 16, weight: .medium),
                leading: NavBarItem(
                    title: "",
                    font: .system(size: 14),
                    image: "back",
                    isSystemImage: false,
                    tint: .black,
                    action: {
                        // dismiss
                        dismiss()
                    }
                )
            )
        )
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
}


#Preview {
    MapView()
}
