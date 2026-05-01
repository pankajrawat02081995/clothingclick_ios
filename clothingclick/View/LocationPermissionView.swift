//
//  LocationPermissionView.swift
//  clothingclick
//
//  Created by DavidBisht on 20/04/26.
//

import SwiftUI
import CoreLocation

struct LocationPermissionView: View {
    @StateObject private var locationManager = LocationManager()
    @Environment(\.dismiss) private var dismiss
    @Binding var showPopup: Bool
    
    var body: some View {
        ZStack {
            // Background dim
            AppColor.blackColor.opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        showPopup = false
                    }
                }
            VStack(spacing: 20) {
                Image(.location)
                    .font(.system(size: 80))
                    .foregroundStyle(.blue)
                    .symbolEffect(.pulse, options: .repeating)
                    .padding(.top, 16)
                
                VStack(spacing: 5) {
                    Text(Constants.turnOnLocation)
                        .font(AppFont.bold.font(size: 15.0))
                        .fontWeight(.bold)
                    Text(Constants.loacationPermissionSubTitle)
                        .font(AppFont.regular.font(size: 13.0))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                // Permission Button
                Group {
                    if locationManager.authorizationStatus == .notDetermined {
                        Button(action: {
                            locationManager.requestPermission()
                        }) {
                            Text(Constants.allowAccess)
                                .font(AppFont.medium.font(size: 15.0))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppColor.blackColor)
                                .foregroundColor(AppColor.whiteColor)
                                .cornerRadius(8)
                        }
                        
                    } else if locationManager.authorizationStatus == .authorizedWhenInUse ||
                                locationManager.authorizationStatus == .authorizedAlways {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(AppColor.blackColor)
                            .frame(height: 44)
                            .overlay {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(AppColor.greenColor)
                                    Text(Constants.locationAccessGranted)
                                        .font(AppFont.medium.font(size: 15.0))
                                        .foregroundColor(AppColor.whiteColor)
                                    
                                }
                            }
                    } else {
                        Button( action: {
                            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(settingsURL)
                            }
                        }){
                            Text(Constants.openSettings)
                                .font(AppFont.medium.font(size: 15.0))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppColor.blackColor)
                                .foregroundColor(AppColor.whiteColor)
                                .cornerRadius(8)
                        }
                    }
                }
                .onChange(of: locationManager.authorizationStatus) { oldValue, status in
                    if status == .authorizedWhenInUse || status == .authorizedAlways {
                        // Permission granted, dismiss after short delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dismiss()
                        }
                    }
                }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 30)
            .transition(.scale.combined(with: .opacity))
        }
    }
}


#Preview {
    LocationPermissionView(showPopup: .constant(true))
}
