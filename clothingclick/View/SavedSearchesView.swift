//
//  SavedSearchesView.swift
//  clothingclick
//
//  Created by DavidBisht on 05/05/26.
//

import SwiftUI

struct SavedSearchesView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: SavedSearchesViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(Array(vm.savedSearches.enumerated()), id: \.offset) { _, savedSearch in
                    VStack(spacing: 0) {
                        HStack(spacing: 10) {
                            VStack(alignment: .leading) {
                                Text(savedSearch.title)
                                    .font(AppFont.regular.font(size: 17))
                                Text("\(savedSearch.itemsCount)")
                                    .font(AppFont.regular.font(size: 13))
                            }
                            Spacer()
                            Button {
                                print("Delete")
                            } label: {
                                Image(.delete)
                            }
                            Button {
                                print("Edit")
                            } label: {
                                Image(.edit)
                            }
                        }
                        .padding()
                        CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .onAppear() {
            vm.mockData()
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: Constants.savedSearches.localizedCapitalized,
                font: AppFont.medium.font(size: 13.0),
                leading: NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "back",
                    isSystemImage: false,
                    action: {
                        dismiss()
                    }
                )
            )
        )
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
    
}

//#Preview {
//    SavedSearchesView()
//}
