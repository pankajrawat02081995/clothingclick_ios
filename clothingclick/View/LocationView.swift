//
//  LocationView.swift
//  clothingclick
//
//  Created by DavidBisht on 22/04/26.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 53.5461, longitude: -113.4938), // Edmonton
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Environment(\.dismiss) var dismiss
    @State private var address: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
                .safeAreaInset(edge: .bottom) {
                    bottomCard
                        .background(Color.white)
                }
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
                        self.dismiss()
                    }
                )
            )
        )
        .toolbarBackground(.visible, for: .navigationBar)

    }
    
    private var bottomCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(Constants.locationViewTitle)
                .font(AppFont.medium.font(size: 17.0))
                .foregroundColor(AppColor.blackColor)
            
            TextField(Constants.AppName, text: $address)
                .focused($isFocused)
                .font(AppFont.regular.font(size: 13.0))
                .foregroundColor(AppColor.blackColor)
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(8)
            
            Button(action: {
                isFocused = false
                print("Save tapped")
            }) {
                Text(Constants.save)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .font(AppFont.medium.font(size: 15.0))
                    .foregroundColor(AppColor.whiteColor)
                    .cornerRadius(8)
            }
        }
        .padding(20)
        .background(Color.white)
        .shadow(radius: 10)
    }
}
#Preview {
    LocationView()
}
