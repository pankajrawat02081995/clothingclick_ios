//
//  DistanceView.swift
//  clothingclick
//
//  Created by DavidBisht on 08/05/26.
//


import SwiftUI
import MapKit

struct DistanceView: View {
    
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    let centerCoordinate = CLLocationCoordinate2D(
        latitude: 37.3346,
        longitude: -122.0090
    )
    
    // Radius in meters
    @State private var radius: CGFloat = 1000
    @State private var kilometers: CGFloat = 1
    
    @Environment(\.dismiss) var dismiss
    @State private var address: String = ""
    @State private var resultCount: Int = 15
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
//            .ignoresSafeArea()
            .safeAreaInset(edge: .bottom) {
                selectRadius
                    .background(Color.white)
            }
            .safeAreaInset(edge: .top, content: {
                enterAddress
            })
            .onAppear {
                updateCamera()
            }
            .onChange(of: radius) {
                updateCamera()
            }
            
        }
        .customNavigationBar(
            config: NavBarConfig(
                title: Constants.distance,
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
    
    private var enterAddress: some View {
        TextField(Constants.addressOrPostalCode, text: $address)
            .focused($isFocused)
            .font(AppFont.regular.font(size: 13.0))
            .foregroundColor(AppColor.blackColor)
            .padding()
            .background(AppColor.whiteColor)
            .cornerRadius(5)
            .padding()
            .shadow(radius: 4)
    }
    
    private var selectRadius: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(Constants.selectRadius)
                    .font(AppFont.regular.font(size: 15))
                    .foregroundColor(AppColor.blackColor)
                Spacer()
                Text("\(Int(kilometers))\(Constants.km)")
                    .font(AppFont.regular.font(size: 15))
                    .foregroundColor(AppColor.blackColor)
            }
            CustomSlider(
                value: $kilometers,
                range: 0...100,
                step: 1,
                useIntegerStep: true
            ) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(AppColor.grayColor)
            } fill: {
                RoundedRectangle(cornerRadius: 5)
                    .fill(AppColor.blackColor)
            } thumb: {
                Circle()
                    .fill(.black)
            }
            .padding(.bottom, 10)
            
            Button(action: {
                isFocused = false
                print("view tapped")
            }) {
                Text("\(Constants.view) \(resultCount) \(resultCount == 1 ? Constants.result : Constants.results)")
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
//        .shadow(radius: 10)
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
    DistanceView()
}
