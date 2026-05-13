//
//  StoreHoursRowView.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//


import SwiftUI

struct StoreHoursRowView: View {

    @Binding var day: StoreDayModel

    var body: some View {
        HStack(spacing: 12) {

            Text(day.day)
                .font(.subheadline)
                .frame(width: 80, alignment: .leading)

            HStack(spacing: 8) {

                TimeInputView(
                    placeholder: "HH:MM",
                    text: $day.openingTime
                )

                Menu {
                    ForEach(TimePeriod.allCases, id: \.self) { period in
                        Button(period.rawValue) {
                            day.openingPeriod = period
                        }
                    }
                } label: {
                    Text(day.openingPeriod.rawValue)
                        .font(.caption)
                        .foregroundColor(.black)
                }
            }
            .frame(width: 100)

            HStack(spacing: 8) {

                TimeInputView(
                    placeholder: "HH:MM",
                    text: $day.closingTime
                )

                Menu {
                    ForEach(TimePeriod.allCases, id: \.self) { period in
                        Button(period.rawValue) {
                            day.closingPeriod = period
                        }
                    }
                } label: {
                    Text(day.closingPeriod.rawValue)
                        .font(.caption)
                        .foregroundColor(.black)
                }
            }
            .frame(width: 100)
        }
    }
}
//import SwiftUI

//struct StoreHoursRowView: View {
//
//    @Binding var day: StoreDayModel
//
//    var body: some View {
//        HStack(spacing: 12) {
//
//            Text(day.day)
//                .font(.subheadline)
//                .frame(width: 80, alignment: .leading)
//
//            HStack(spacing: 8) {
//
//                TimeInputView(
//                    placeholder: "HH:MM",
//                    text: $day.openingTime
//                )
//
//                Menu {
//                    ForEach(TimePeriod.allCases, id: \.self) { period in
//                        Button(period.rawValue) {
//                            day.openingPeriod = period
//                        }
//                    }
//                } label: {
//                    Text(day.openingPeriod.rawValue)
//                        .font(.caption)
//                        .foregroundColor(.black)
//                }
//            }
//            .frame(width: 100)
//
//            HStack(spacing: 8) {
//
//                TimeInputView(
//                    placeholder: "HH:MM",
//                    text: $day.closingTime
//                )
//
//                Menu {
//                    ForEach(TimePeriod.allCases, id: \.self) { period in
//                        Button(period.rawValue) {
//                            day.closingPeriod = period
//                        }
//                    }
//                } label: {
//                    Text(day.closingPeriod.rawValue)
//                        .font(.caption)
//                        .foregroundColor(.black)
//                }
//            }
//            .frame(width: 100)
//        }
//    }
//}
