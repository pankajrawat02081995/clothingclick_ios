//
//  SavedSearchView.swift
//  clothingclick
//
//  Created by DavidBisht on 05/05/26.
//

import SwiftUI

struct SavedSearchView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = SavedSearchViewModel()
    @FocusState var focusedField: Field?
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                FilterCardView(viewModel: vm.filterViewModel, isHideViewsButton: true, ownListView: true) {
                    VStack {
                        notifyWhenItemCount
                        
                        CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                        bottomCard
                        
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    focusedField = nil // dismiss keyboard
                })
            }
            .onChange(of: focusedField) { _, field in
                   DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                       withAnimation {
                           if let field = field {
                               proxy.scrollTo(field)
                           }
                       }
                   }
               }
        }
        .customNavigationBar(
            config: NavBarConfig(
                title: Constants.savedSearches.localizedCapitalized,
                font: AppFont.medium.font(size: 15),
                leading: NavBarItem(
                    title: nil,
                    font: AppFont.medium.font(size: 13),
                    image: "back",
                    isSystemImage: false,
                    tint: AppColor.blackColor,
                    action: {
                        dismiss()
                    }
                ),
                trailing: [
                    NavBarItem(
                        title: Constants.clearAll,
                        font: AppFont.medium.font(size: 10),
                        image: nil,
                        isSystemImage: false,
                        tint: AppColor.blackColor,
                        action: {
                            vm.filterViewModel.clearAll()
                        }
                    ),
                ]
            )
        )
        .toolbar(.hidden, for: .tabBar)
    }
    
    private var notifyWhenItemCount: some View {
        HStack {
            Text(Constants.notifyMeWhenNewItemsAreListed)
                .font(AppFont.regular.font(size: 15))
                .foregroundStyle(AppColor.blackColor)
            Spacer()
            HStack() {
                TextField("0", text: $vm.itemCount)
                .keyboardType(.numberPad)
                .font(AppFont.regular.font(size: 15))
                .foregroundColor(AppColor.blackColor)
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
                .focused($focusedField, equals: .savedSearchItemsField)
//                .onChange(of: vm.itemCount) { _, newValue in
//                    // Allow only numbers
//                    let filtered = newValue.filter { $0.isNumber }
//                    // Limit to 3 digits
//                    vm.itemCount = String(filtered.prefix(3))
//                }
                
            }
            .frame(width: 43, height: 22, alignment: .center)
            .cornerRadius(5)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(AppColor.blackColor, lineWidth: 1)
            }
        }
        .id(Field.savedSearchItemsField)
        .contentShape(Rectangle())
        .padding()
    }
    
    private var bottomCard: some View {
        VStack(alignment: .leading, spacing: 1) {
            
            Text(Constants.titleOfSearch)
                .font(AppFont.medium.font(size: 17.0))
                .foregroundColor(AppColor.blackColor)
            
            TextField(Constants.enterHere, text: $vm.searchTitle)
                .font(AppFont.regular.font(size: 13.0))
                .foregroundColor(AppColor.blackColor)
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(5)
                .focused($focusedField, equals: .savedSearchTitleField)
                .padding(.vertical,12)
                .id(Field.savedSearchTitleField)
            HStack(spacing: 10) {
                Button(action: {
//                    isFocused = false
                    print("Cancel tapped")
                }) {
                    Text(Constants.cancel)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColor.whiteColor)
                        .font(AppFont.medium.font(size: 15.0))
                        .foregroundColor(AppColor.blackColor)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(AppColor.clearColor)
                                .stroke(AppColor.blackColor, lineWidth: 1)
                        )
                }
                Button(action: {
//                    isFocused = false
                    print("Save tapped")
                }) {
                    Text(Constants.save)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColor.blackColor)
                        .font(AppFont.medium.font(size: 15.0))
                        .foregroundColor(AppColor.whiteColor)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(AppColor.clearColor)
                                .stroke(AppColor.blackColor, lineWidth: 1)
                        )
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
    }

    
}

#Preview {
    SavedSearchView()
}
