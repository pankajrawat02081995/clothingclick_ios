//
//  ChatView.swift
//  clothingclick
//
//  Created by DavidBisht on 07/05/26.
//

import SwiftUI

struct ChatView: View {
    
    @State var titleString: String
    @State private var product: Product = Product.sample
    
    @StateObject var vm: ChatViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocused: Bool
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack {
                            productView
                            ForEach($vm.chatMessages) { $row in
                                let isUser = row.userId == 45
                                chatView(row: row, alignment: isUser ? .trailing : .leading, isUser: isUser)
                            }
                        }
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    bottomCard
                        .background(Color.white)
                }
            }
            .onAppear() {
                vm.mockData()
            }
            .customNavigationBar(config: NavBarConfig(
                title: titleString,
                titleImage: vm.titleImage,
                font: AppFont.medium.font(size: 15),
                leading:  NavBarItem(
                    title: "",
                    font: .system(size: 14),
                    image: "back",
                    isSystemImage: false,
                    tint: .black,
                    action: {
                        dismiss()
                    }
                )
            ))
            .toolbar(.hidden, for: .tabBar)
        }
    }
    
    private var productView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                AsyncImage(url: URL(string: "")) { image in
                    Image(product.sellerImage)
                        .resizable()
                } placeholder: {
                    Image(product.sellerImage)
                        .resizable()
                        .background(AppColor.borderColor)
                }
                .frame(width: 69, height: 75)
                .border(AppColor.borderColor, width: 1)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.sellerName)
                        .font(AppFont.medium.font(size: 15))
                        .foregroundStyle(AppColor.blackColor)
                    Text(product.size+" · \(product.price))")
                        .font(AppFont.medium.font(size: 13))
                        .foregroundStyle(AppColor.blackColor)
                    NavigationLink {
                        ReviewsView()
                    } label: {
                        HStack(alignment: .center, spacing: 2) {
                            Image(.star)
                            Text("4.9 (9 \(Constants.reviews))")
                                .font(AppFont.medium.font(size: 10))
                                .foregroundStyle(AppColor.darkGrayTextColor)
                        }
                    }
                }
                
                Spacer()
                NavigationLink(destination: ProfileView()) {
                    Image(.rightArrow)
                }
            }
            .padding()
            .background(AppColor.lightGrayColor)
        }
        .padding()
    }
    
    func chatView(row: Chat, alignment: HorizontalAlignment, isUser: Bool) -> some View {
        HStack {
            let maxWidth = UIScreen.main.bounds.width-((UIScreen.main.bounds.width*20)/100)
            if alignment == .trailing {
                Spacer()
            }
            HStack {
                if alignment == .trailing {
                    Spacer()
                }
                VStack(alignment: .trailing) {
                    Text(row.message)
                        .font(AppFont.regular.font(size: 13))
                        .foregroundStyle(isUser ? AppColor.whiteColor : AppColor.blackColor)
                        .padding()
                        .background(isUser ? AppColor.blackColor : AppColor.whiteColor)
                        .cornerRadius(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(AppColor.clearColor)
                                .stroke(isUser ? AppColor.clearColor : AppColor.borderColor, lineWidth: 1)
                        }
                    HStack(spacing: 0) {
                        Text(row.date)
                            .font(AppFont.regular.font(size: 10))
                            .foregroundStyle(AppColor.blackColor)
                        if row.isSeen {
                            Text(Constants.spaceDotSpaceSeen)
                                .font(AppFont.regular.font(size: 10))
                                .foregroundStyle(AppColor.blackColor)
                        }
                    }
                }
                if alignment == .leading {
                    Spacer()
                }
            }
            .frame(maxWidth: maxWidth)
            
            if alignment == .leading {
                Spacer()
            }

        }
        .frame(maxWidth: .infinity)
        .padding(12)
    }
    
    private var bottomCard: some View {
        HStack(alignment: .bottom, spacing: 12) {
            Button(action: {
            }) {
                Image(.placeholder)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .padding(.vertical,16)
            }
            HStack(alignment: .bottom) {
                CustomTextEditor(
                    text: $vm.inputMessage,
                    isFocused: $isFocused,
                    placeholder: Constants.typeHere,
                    cornerRadius: 0,
                    placeholderColor: AppColor.blackColor,
                    textColor: AppColor.blackColor,
                    backgroundColor: AppColor.clearColor,
                    strokeColor: AppColor.clearColor,
                    uiFont: AppFont.regular.uiFont(size: 13),
                    minHeight: 28,
                    maxHeight: 70
                )
                Button(action: {
                    isFocused = false
                    vm.sendMessage()
                }) {
                    Image(.sendMessage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(.vertical,9)
                }
            }
            .padding(.horizontal)
            .padding(.vertical,10)
            .background(Color.gray.opacity(0.15))
            .cornerRadius(5)
        }
        .padding(20)
        .background(AppColor.whiteColor)
//        .shadow(radius: 10)
    }


}

#Preview {
    ChatView(titleString: "test", vm: ChatViewModel(chatID: "ds"))
}
