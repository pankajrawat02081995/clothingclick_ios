//
//  FilterCardView.swift
//  clothingclick
//
//  Created by DavidBisht on 30/04/26.
//

import SwiftUI

struct FilterCardView<BottomContent: View>: View {
    
    @ObservedObject var viewModel: FilterViewModel
    private let isHideViewsButton: Bool
    private let ownListView: Bool
    private let bottomContent: BottomContent
      
      init(
          viewModel: FilterViewModel,
          isHideViewsButton: Bool = false,
          ownListView: Bool = false,
          @ViewBuilder bottomContent: () -> BottomContent = { EmptyView() }
      ) {
          self.viewModel = viewModel
          self.isHideViewsButton = isHideViewsButton
          self.ownListView = ownListView
          self.bottomContent = bottomContent()
      }
        
    var body: some View {
        VStack(spacing: 0) {
            
            if ownListView == true {
                ForEach($viewModel.items) { $item in
                    VStack(spacing: 0) {
                        rowView(item: $item)
                            .padding()
                        CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                    }
                }
                bottomContent
            } else {
                List {
                    ForEach($viewModel.items) { $item in
                        VStack(spacing: 0) {
                            rowView(item: $item)
                                .padding()
                            CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.hidden)
                    }
                    bottomContent
                        .listRowInsets(EdgeInsets(.zero))
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            
            if isHideViewsButton == false {
                // Bottom Button
                Button(action: {
                    viewModel.apply()
                }) {
                    Text("\(Constants.view) \(viewModel.resultCount) \(viewModel.resultCount == 1 ? Constants.result : Constants.results)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
        }
        .navigationDestination(item: $viewModel.route) { route in
                       destinationView(route: route)
                   }
        .toolbarBackground(.visible, for: .navigationBar)

    }

    // MARK: - Row Builder
    @ViewBuilder
    private func rowView(item: Binding<FilterItem>) -> some View {
        switch item.wrappedValue.type {

        case .toggle(let isOn):
            HStack {
                Text(item.wrappedValue.title)
                    .font(AppFont.medium.font(size: 15))
                    .foregroundStyle(AppColor.blackColor)
                Spacer()
                
                SlidingSwitch(isOn: Binding(
                    get: { isOn },
                    set: { newValue in
                        item.wrappedValue.type = .toggle(isOn: newValue)
                    }
                ))
                
//                Toggle("", isOn: Binding(
//                    get: { isOn },
//                    set: { newValue in
//                        item.wrappedValue.type = .toggle(isOn: newValue)
//                    }
//                ))
//                .labelsHidden()
            }

        case .navigation(let value):
            HStack {
                Text(item.wrappedValue.title)
                    .font(AppFont.regular.font(size: 15))
                    .foregroundStyle(AppColor.blackColor)
                Spacer()
                if let value {
                    Text(value)
                        .font(AppFont.regular.font(size: 15))
                        .foregroundStyle(AppColor.blueColor)
                }
                Image(.rightArrow)
                    .renderingMode(.template)
                    .foregroundColor(AppColor.grayColor)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                        viewModel.select(item.wrappedValue.key)
                    }
        }
    }
    
    
    @ViewBuilder
    private func destinationView(route: FilterRoute) -> some View {
        switch route {
            
        case .department:
            DepartmentView()
            
        case .category:
            CategoryView()
            
        case .size:
            SizeView(category: Constants.menswear, vm: SizeSelectionViewModel(selectedTab: Constants.menswear, categoryType: .menswear))
            
        case .style:
            StyleView()
            
        case .brandName:
            BrandView()
            
        case .color:
            ColorView()
            
        case .condition:
            ConditionView()

        case .seller:
            SellerView()

        case .price:
            PriceView()
            
        case .distance:
            DistanceView()
            
        case .sort:
            SortView()

        case .subCategory:
            if let category = viewModel.items.first {
                SubCategoryView(vm: SubCategoryViewModel(category: category))
            } else {
                EmptyView()
            }
        }
    }
    
}

//#Preview {
//    FilterCardView(  title: "Filter",
//                 items: [
//                    FilterItem(title: "My Sizes", type: .toggle(isOn: true)),
//                    FilterItem(title: "Department", type: .navigation(value: "Menswear")),
//                    FilterItem(title: "Category", type: .navigation(value: nil)),
//                    FilterItem(title: "Size", type: .navigation(value: "S,S,28,M,S")),
//                    FilterItem(title: "Style", type: .navigation(value: nil)),
//                    FilterItem(title: "Brand Name", type: .navigation(value: nil)),
//                    FilterItem(title: "Color", type: .navigation(value: nil)),
//                    FilterItem(title: "Condition", type: .navigation(value: nil)),
//                    FilterItem(title: "Seller", type: .navigation(value: nil)),
//                    FilterItem(title: "Price", type: .navigation(value: nil)),
//                    FilterItem(title: "Distance", type: .navigation(value: nil)),
//                    FilterItem(title: "Sort", type: .navigation(value: nil))
//                 ]
//    )
//}
