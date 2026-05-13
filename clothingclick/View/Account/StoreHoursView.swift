//
//  StoreHoursView.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import SwiftUI

struct StoreHoursView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = StoreHoursViewModel()

    var body: some View {
        VStack(spacing: 0) {

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    Text("Store Status")
                        .font(.headline)
                        .padding(.top)

                    VStack(spacing: 16) {

                        StatusToggleView(
                            title: "Temporarily Closed",
                            subtitle: "E.g. closed for remodelling",
                            isOn: $viewModel.isTemporarilyClosed
                        )

                        StatusToggleView(
                            title: "Open",
                            subtitle: "Select the hours for each day below",
                            isOn: $viewModel.isOpen
                        )
                    }

                    VStack(spacing: 12) {

                        HStack {
                            Spacer()

                            Text("Opening")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(width: 100)

                            Text("Closing")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(width: 100)
                        }

                        ForEach($viewModel.storeDays) { $day in
                            StoreHoursRowView(day: $day)
                        }
                    }
                }
                .padding()
            }

            Button(action: {
                viewModel.saveStoreHours()
            }) {
                Text(Constants.save)
                    .font(AppFont.medium.font(size: 15))
                    .foregroundStyle(AppColor.whiteColor)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColor.blackColor)
                    .cornerRadius(5)
            }
            .padding()
        }
        .navigationTitle("Store Hours")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }
}

//#Preview {
//    NavigationStack {
//        StoreHoursView()
//    }
//}
