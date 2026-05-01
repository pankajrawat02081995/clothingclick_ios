//
//  ContactRowView.swift
//  clothingclick
//
//  Created by DavidBisht on 27/04/26.
//

import SwiftUI

struct ContactRowView: View {
    
    let title: String
    let value: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    if title.isEmpty == false {
                        Text(title)
                            .font(AppFont.regular.font(size: 12))
                            .foregroundStyle(AppColor.blackColor)
                    }
                    Text(value)
                        .font(AppFont.regular.font(size: 15))
                        .foregroundStyle(AppColor.blackColor)
                }
                
                Spacer()
                
                Image(icon)
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(AppColor.blackColor)
            }
        }
    }
}

#Preview {
    ContactRowView(title: "email", value: "dscdscds", icon: "email") {
        
    }
}
