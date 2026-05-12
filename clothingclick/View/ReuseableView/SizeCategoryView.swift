//
//  SizeCategoryView.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//

import SwiftUI

struct SizeCategoryView: View {
    
    let title: String
    let titleFont: Font?
    let sizes: [String]
    let icon: String?
    let isSystemImage: Bool
    let selectedSize: String?
    var unSelectColor: Color = .clear
    let strokeColors: (select: Color,unselect: Color)?
    
    let onSelect: (String) -> Void
    
    private let columns = [
        GridItem(.adaptive(minimum: 65), spacing: 10)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // Header
            HStack {
                if let icon = icon {
                    if isSystemImage {
                        Image(systemName: icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    } else {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                }
                
                Text(title)
                    .font(titleFont != nil ? titleFont! : AppFont.regular.font(size: 17.0))
                    .foregroundStyle(AppColor.blackColor)
            }
            
            // Grid
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(sizes, id: \.self) { size in
                    
                    Button {
                        onSelect(size)
                    } label: {
                        Text(size)
                            .font(AppFont.regular.font(size: 13.0))
                            .frame(width: 65, height: 36)
                            .background(
                                selectedSize == size ? AppColor.blackColor : unSelectColor
                            )
                            .foregroundColor(
                                selectedSize == size ? AppColor.whiteColor : AppColor.blackColor
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        selectedSize == size ?
                                            strokeColors != nil ? strokeColors!.select : AppColor.blackColor :
                                            strokeColors != nil ? strokeColors!.unselect : AppColor.borderColor,
                                        lineWidth: 1
                                    )
                            )
                            .cornerRadius(5)
                    }
                }
            }
        }
    }
}
