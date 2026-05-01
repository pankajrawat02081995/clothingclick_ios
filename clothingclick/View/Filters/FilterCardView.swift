//
//  FilterCardView.swift
//  clothingclick
//
//  Created by DavidBisht on 30/04/26.
//

import SwiftUI

struct FilterCardView: View {
    
    @ObservedObject var viewModel: FilterViewModel
    
    
    var body: some View {
        VStack(spacing: 0) {

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
            }
            .listStyle(.plain)
            

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
        .navigationDestination(item: $viewModel.route) { route in
                       destinationView(route: route)
                   }
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
                Toggle("", isOn: Binding(
                    get: { isOn },
                    set: { newValue in
                        item.wrappedValue.type = .toggle(isOn: newValue)
                    }
                ))
                .labelsHidden()
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
//            DepartmentView()
            EmptyView()
            
        case .category:
//            CategoryView()
            EmptyView()
            
        case .size:
//            SizeView()
            EmptyView()

            
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
//            DistanceView()
            EmptyView()

            
        case .sort:
//            SortView()
            EmptyView()

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
