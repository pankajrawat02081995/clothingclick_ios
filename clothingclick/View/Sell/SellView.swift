//
//  SellView.swift
//  clothingclick
//
//  Created by DavidBisht on 08/05/26.
//

import SwiftUI

struct SellView: View {
    
    let departments: [String] = [Constants.menswear, Constants.womenswear]
    let categories: [String] = [Constants.tops, Constants.bottoms, Constants.outerwear, Constants.jeans, Constants.accessories]
    let subcategories: [String] = ["Vest", "Windbreaker", "Track Jacket", "Denim Jacket", "Ski Jacket"]
    
    @State private var selectedDepartment: String?
    @State private var selectedCategory: String?
    @State private var selectedSubcategory: String?
    @State private var isActiveSellSecondView: Bool = false
    
    var validate: Bool {
        selectedDepartment != nil &&
        selectedCategory != nil &&
        selectedSubcategory != nil
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 20) {
                            departmentSection
                            
                            if selectedDepartment != nil {
                                categorySection
                            }
                            
                            if selectedCategory != nil {
                                subcategorySection
                            }
                        }
                        .padding()
                    }
                }
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                saveButton
            }
        }
        .navigationDestination(isPresented: $isActiveSellSecondView, destination: {
            SellSecondView(department: selectedDepartment ?? "", category: selectedCategory ?? "", subcategory: selectedSubcategory ?? "")
        })
        .customNavigationBar(
            config:NavBarConfig(
                title: Constants.sell,
                font: AppFont.medium.font(size: 13.0),
                
//                leading: NavBarItem(
//                    title: nil,
//                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
//                    image: "back",
//                    isSystemImage: false,
//                    action: { }
//                ),
//                
                trailing: [NavBarItem(
                    title: nil,
                    font: AppFont.medium.font(size: 10, relativeTo: .title),
                    image: "cross",
                    isSystemImage: false,
                    action: {
                        resetSelection()
                    }
                )]
            )
        )
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private func resetSelection() {
        selectedDepartment = nil
        selectedCategory = nil
        selectedSubcategory = nil
    }
    
    private var departmentSection: some View {
        grid(title: Constants.department, items: departments, selecteditems: selectedDepartment) { department in
            print("Department: \(department)")
            if selectedDepartment != department {
                selectedCategory = nil
                selectedSubcategory = nil
                selectedDepartment = department
            }
        }
    }
    
    private var categorySection: some View {
        grid(title: Constants.category, items: categories, selecteditems: selectedCategory) { category in
            print("Category: \(category)")
            if selectedCategory != category {
                selectedSubcategory = nil
                selectedCategory = category
            }
        }
    }
    
    private var subcategorySection: some View {
        grid(title: Constants.department, items: subcategories, selecteditems: selectedSubcategory) { subcategory in
            print("Subcategory: \(subcategory)")
            if selectedSubcategory != subcategory {
                selectedSubcategory = subcategory
            }
        }
    }
    
    
    private func grid(
        title: String,
        items: [String],
        selecteditems: String?,
        action: @escaping (String) -> Void
    ) -> some View {
        
        VStack(alignment: .leading) {
          
            Text(title)
                .font(AppFont.medium.font(size: 17))
                .foregroundStyle(AppColor.blackColor)
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(items, id: \.self) { item in
                    let isSelected : Bool = selecteditems == item
                    Button {
                        action(item)
                    } label: {
                        VStack {
                            if categories.contains(item) {
                                Image(.placeholder)
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(isSelected ? AppColor.whiteColor : AppColor.blackColor)
                            }
                            Text(item)
                                .font(AppFont.regular.font(size: 13))
                                .foregroundStyle(isSelected ? AppColor.whiteColor : AppColor.blackColor)
                        }
                        .padding(14)
                        .frame(maxWidth: .infinity)
                        .background(isSelected ? AppColor.blackColor : AppColor.clearColor)
                        .cornerRadius(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(AppColor.clearColor)
                                .stroke(isSelected ? AppColor.blackColor : AppColor.borderColor, lineWidth: 1)
                        }
                    }
                }
            }
        }
    }
    
    private var saveButton: some View {
        Button(action: {
            if validate {
                isActiveSellSecondView = true
            }
        }) {
            Text(Constants.save)
                .frame(maxWidth: .infinity)
                .padding()
                .background(validate ? AppColor.blackColor : AppColor.darkGrayColor)
                .font(AppFont.medium.font(size: 15.0))
                .foregroundColor(AppColor.whiteColor)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(AppColor.clearColor)
                        .stroke(validate ? AppColor.blackColor : AppColor.darkGrayColor, lineWidth: 1)
                )
        }
        .padding()
    }
    
}

#Preview {
    SellView()
}
