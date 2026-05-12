//
//  SearchBrandsAndDesignersView.swift
//  clothingclick
//
//  Created by DavidBisht on 11/05/26.
//

import SwiftUI

struct SearchBrandsAndDesignersView: View {
    
    @StateObject private var vm = SearchBrandsAndDesignersViewModel()
    @Environment(\.dismiss) var dismiss
    var onSave: ((String)-> Void)? = nil
    
    var body: some View {
        ZStack {
            VStack {
                searchSection
                    .padding()
                searchedListSection
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                saveButton
            }
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: Constants.brandName.capitalized,
                font: AppFont.medium.font(size: 13.0),
                
                leading: NavBarItem(
                    title: nil,
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: nil,
                    isSystemImage: false,
                    action: { }
                ),
                
                trailing: [NavBarItem(
                    title: nil,
                    font: AppFont.medium.font(size: 10, relativeTo: .title),
                    image: "cross",
                    isSystemImage: false,
                    action: {
                        dismiss()
                    }
                )]
            )
        )
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private var searchSection: some View {
        HStack(spacing: 10) {
            Image(.search)
            
            TextField(
                "",
                text: $vm.search,
                prompt: Text(Constants.searchDesignersAndBrandNames)
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)
            )
            .font(AppFont.regular.font(size: 13))
            .foregroundStyle(AppColor.blackColor)
            .submitLabel(.search)
            .onSubmit {
                vm.searchResult()
            }
            .onChange(of: vm.search) { _, _ in
                vm.searchResult()
            }
            
        }
        .padding(12)
        .background(AppColor.lightGrayColor)
        .cornerRadius(10)
    }
    
    private var searchedListSection: some View {
        List {
            ForEach(vm.searchResults, id: \.self) { item in
                
                VStack(spacing: 0) {
                    
                    Button {
                        vm.selectedItem = item
                    } label: {
                        
                        HStack {
                            
                            Text(item)
                                .font(AppFont.regular.font(size: 15))
                                .foregroundColor(AppColor.blackColor)

                            Spacer()

                            Image(.roundCheck)
                                .renderingMode(.template)
                                .foregroundColor(
                                    vm.selectedItem == item
                                    ? AppColor.blackColor
                                    : AppColor.grayColor
                                )
                        }
                        .padding()
                    }

                    CustomDivider(
                        color: AppColor.borderColor,
                        lineWidth: 1
                    )
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(AppColor.clearColor)
            }
        }
        .listStyle(.plain)
    }
    
    private var saveButton: some View {
        Button(action: {
            onSave?(vm.selectedItem)
        }) {
            Text(Constants.save)
                .frame(maxWidth: .infinity)
                .padding()
                .font(AppFont.regular.font(size: 15))
                .background(AppColor.blackColor)
                .foregroundColor(AppColor.whiteColor)
                .cornerRadius(5)
                .padding()
        }
    }
}

#Preview {
    SearchBrandsAndDesignersView()
}
