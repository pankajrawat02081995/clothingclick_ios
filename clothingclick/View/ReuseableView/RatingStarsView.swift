//
//  RatingStarsView.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import SwiftUI

struct RatingStarsView: View {

    @Binding var selectedRating: Int

    var body: some View {
        HStack(spacing: 12) {
            ForEach(1...5, id: \.self) { index in
                Image(index <= selectedRating ? "ratingStar" : "emptyStar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 34, height: 34)
                    .onTapGesture {
                        selectedRating = index
                    }
            }
        }
    }
}

//#Preview {
//    RatingStarsView()
//}
