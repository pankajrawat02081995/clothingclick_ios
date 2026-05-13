//
//  StoreHoursCardView.swift
//  clothingclick
//
//  Created by DavidBisht on 27/04/26.
//

import SwiftUI

struct StoreHoursCardView: View {
    
    let hours: [(day: String, time: String)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text("Store Hours")
                .font(AppFont.semibold.font(size: 25))
                .foregroundStyle(AppColor.blackColor)
            
            HStack(spacing: 0) {
                Text("Open")
                    .font(AppFont.semibold.font(size: 15))
                    .foregroundStyle(AppColor.greenColor)
                
                Text(" until 10:00PM")
                    .font(AppFont.regular.font(size: 15))
                    .foregroundStyle(AppColor.blackColor)
            }
            
            ForEach(hours, id: \.day) { item in
                HStack {
                    Text(item.day)
                        .font(AppFont.regular.font(size: 15))
                        .foregroundStyle(AppColor.blackColor)
                    Spacer()
                    Text(item.time)
                        .font(AppFont.regular.font(size: 15))
                        .foregroundStyle(AppColor.blackColor)
                }
                .font(.subheadline)
            }
        }
        .padding()
    }
}

//#Preview {
//    StoreHoursCardView()
//}
