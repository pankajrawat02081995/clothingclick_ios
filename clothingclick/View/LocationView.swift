//
//  LocationView.swift
//  clothingclick
//
//  Created by DavidBisht on 22/04/26.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @State private var cameraPosition: MapCameraPosition = .automatic
    var onSave: ((String) -> Void)? = nil
    
    let centerCoordinate = CLLocationCoordinate2D(
        latitude: 37.3346,
        longitude: -122.0090
    )
    
    // Radius in meters
    let radius: CGFloat = 1000
    
    @Environment(\.dismiss) var dismiss
    @State private var address: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Map(position: $cameraPosition) {
                
                // Pin
                Marker("Center", coordinate: centerCoordinate)
                
                // Circle Radius
                MapCircle(center: centerCoordinate,
                          radius: CLLocationDistance(radius))
                .foregroundStyle(.blue.opacity(0.25))
                .stroke(.blue, lineWidth: 2)
            }
            .mapStyle(.standard)
            .ignoresSafeArea()
            .safeAreaInset(edge: .bottom) {
                bottomCard
                    .background(Color.white)
            }
            .onAppear {
                updateCamera()
            }
            .onChange(of: radius) {
                updateCamera()
            }
            
        }
        .customNavigationBar(
            config: NavBarConfig(
                title: Constants.location,
                font: AppFont.medium.font(size: 13.0),
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
        .toolbar(.hidden, for: .tabBar)
    }
    
    private var bottomCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(Constants.locationViewTitle)
                .font(AppFont.medium.font(size: 17.0))
                .foregroundColor(AppColor.blackColor)
            
            TextField(Constants.addressOrPostalCode, text: $address)
                .focused($isFocused)
                .font(AppFont.regular.font(size: 13.0))
                .foregroundColor(AppColor.blackColor)
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(5)
            
            Button(action: {
                isFocused = false
                onSave?(address)
            }) {
                Text(Constants.save)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .font(AppFont.medium.font(size: 15.0))
                    .foregroundColor(AppColor.whiteColor)
                    .cornerRadius(5)
            }
        }
        .padding(20)
        .background(Color.white)
        .shadow(radius: 10)
    }
    
    func updateCamera() {
        
        // Add padding so circle fully fits
        let paddedRadius = radius * 1.4
        
        // Approx conversion meters -> degrees
        let latDelta = paddedRadius / 111_000
        
        let region = MKCoordinateRegion(
            center: centerCoordinate,
            span: MKCoordinateSpan(
                latitudeDelta: latDelta * 2,
                longitudeDelta: latDelta * 2
            )
        )
        
        cameraPosition = .region(region)
    }
}

#Preview {
    LocationView()
}
