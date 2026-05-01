//
//  ContactsSheetView.swift
//  clothingclick
//
//  Created by DavidBisht on 27/04/26.
//

import SwiftUI

struct ContactsSheetView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text(Constants.contacts)
                .font(AppFont.semibold.font(size: 25))
                .foregroundStyle(AppColor.blackColor)
            
            ContactRowView(
                title: "Phone",
                value: "+4234234278",
                icon: "phone"
            ) {
                print("Call tapped")
            }
            
            ContactRowView(
                title: "Email",
                value: "thecomeupveg@gmail.com",
                icon: "email"
            ) {
                print("Email tapped")
            }
            
            ContactRowView(
                title: "",
                value: "Send a Message",
                icon: "contactChat"
            ) {
                print("Message tapped")
            }
        }
        .padding()
    }
}

#Preview {
    ContactsSheetView()
}
