//
//  BuyNowView.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//

import SwiftUI

struct BuyNowView: View {
    
    @StateObject var vm = BuyNowViewModel()
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                productSection
                sizeSection
                deliverySection
                
                if vm.selectedDelivery == .ship {
                    addressSection
                } else {
                    pickupSection
                }
                
                paymentSection
                payButton
            }
            .padding()
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: Constants.buyNow,
                font: AppFont.medium.font(size: 13.0),
                
                leading: NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "back",
                    isSystemImage: false,
                    action: {
                        print("back tapped")
                        self.dismiss()
                    }
                ),
                
                trailing: [NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "share",
                    isSystemImage: false,
                    action: {
                        print("share tapped")
                    }
                )]
            )
        )
    }
    
    private var productSection: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 76, height: 82)
                    .clipped()
            } placeholder: {
                Image(systemName: "photo.on.rectangle.angled")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 76, height: 82)
                    .clipped()
            }

            
            
            VStack(alignment: .leading, spacing: 18) {
                Text(vm.productName)
                    .font(AppFont.regular.font(size: 15))
                    .foregroundStyle(AppColor.blackColor)
                HStack {
                    VStack(alignment: .leading) {
                        Text(Constants.selectSizes)
                            .font(AppFont.medium.font(size: 13))
                            .foregroundStyle(AppColor.darkGrayColor)
                        Text("\(vm.size)")
                            .font(AppFont.regular.font(size: 15))
                            .foregroundStyle(AppColor.blackColor)
                    }
                    .frame(maxWidth: .infinity)
                    VStack(alignment: .leading) {
                        Text(Constants.condition)
                            .font(AppFont.medium.font(size: 13.0))
                            .foregroundStyle(AppColor.darkGrayColor)
                        Text("\(vm.condition)")
                            .font(AppFont.medium.font(size: 13.0))
                            .foregroundStyle(AppColor.blackColor)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 5)
            
            Spacer()
            
            Text(vm.totalPrice)
                .font(AppFont.semibold.font(size: 20))
                .foregroundStyle(AppColor.blackColor)
                .padding(.top, 5)
        }
    }
    
    private var sizeSection: some View {
        SizeCategoryView(
            title: Constants.size,
            titleFont: AppFont.medium.font(size: 17),
            sizes: ["S","M","L","XL","XXL","ES"],
            icon: nil,
            isSystemImage: false,
            selectedSize: vm.selectedSize,
            unSelectColor: AppColor.lightGrayColor,
            strokeColors: (select: AppColor.blackColor, unselect: AppColor.darkGrayTextColor)
        ) { size in
            vm.selectedSize = size
        }
    }
    
    private var deliverySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(Constants.delivery)
                .font(AppFont.medium.font(size: 17.0))
                .foregroundStyle(AppColor.blackColor)
            ForEach(DeliveryType.allCases, id: \.self) { type in
                HStack {
                    if vm.selectedDelivery == type {
                        Image(.fillCircle)
                    } else {
                        Image(.circle)
                    }
                    Text(type.rawValue)
                        .font(AppFont.regular.font(size: 13))
                        .foregroundStyle(AppColor.blackColor)
                    
                    Spacer()
                    Image(type.imageString)
                }
                .padding()
                .background(AppColor.lightGrayColor)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(vm.selectedDelivery == type ? AppColor.blackColor : AppColor.darkGrayTextColor,lineWidth: 1)
                })
                .cornerRadius(5)
                .onTapGesture {
                    vm.selectedDelivery = type
                }
            }
        }
    }
    
    private var pickupSection: some View {
        VStack(alignment: .leading) {
            Text(Constants.pickupLocation)
                .font(AppFont.medium.font(size: 15))
                .foregroundStyle(AppColor.blackColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(Constants.addressesAreSecureAndEncrypted)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.darkGrayTextColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Edmonton")
                        .font(AppFont.semibold.font(size: 13))
                        .foregroundStyle(AppColor.blackColor)
                    Text("Edmonton 36 i 34f")
                        .font(AppFont.regular.font(size: 11))
                        .foregroundStyle(AppColor.brownGrayColor)
                }
                Spacer()
                Text("Free")
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)
            }
            .padding()
            .background(AppColor.lightGrayColor)
        }
        
    }
    
    private var shippingMethod: some View {
        VStack(alignment: .leading) {
            Text(Constants.shippingMethod)
                .font(AppFont.medium.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(Constants.standard)
                        .font(AppFont.semibold.font(size: 13))
                        .foregroundStyle(AppColor.blackColor)
                    Text("3 \(Constants.to) 9 \(Constants.businessDays)")
                        .font(AppFont.regular.font(size: 11))
                        .foregroundStyle(AppColor.brownGrayColor)
                }
                Spacer()
                Text("$16.00")
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)
            }
            .padding()
            .background(AppColor.lightGrayColor)
        }
        
    }
    
    private var addressSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(Constants.address)
                .font(AppFont.medium.font(size: 15))
                .foregroundStyle(AppColor.blackColor)
            Text(Constants.addressesAreSecureAndEncrypted)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.darkGrayColor)
            
            Group {
                textFieldWithTitle(Constants.enterHere, text: $vm.country, title: Constants.countryRegion, focusStateField: .countryField)
                textFieldWithTitle(Constants.enterHere, text: $vm.firstName, title: Constants.firstName, focusStateField: .firstNameField)
                textFieldWithTitle(Constants.enterHere, text: $vm.lastName, title: Constants.lastName, focusStateField: .lastNameField)
                textFieldWithTitle(Constants.enterHere, text: $vm.company, title: "\(Constants.company) (\(Constants.optional))", focusStateField: .companyField)
                textFieldWithTitle(Constants.enterHere, text: $vm.address, title: Constants.address, focusStateField: .addressField)
                textFieldWithTitle(Constants.enterHere, text: $vm.apartment, title: "\(Constants.apartmentEtc) (\(Constants.optional))", focusStateField: .apartmentField)
                textFieldWithTitle(Constants.enterHere, text: $vm.city, title: Constants.city, focusStateField: .cityField)
                textFieldWithTitle(Constants.enterHere, text: $vm.province, title: Constants.province, focusStateField: .provinceField)
                textFieldWithTitle(Constants.enterHere, text: $vm.postalCode, title: Constants.postalCode, focusStateField: .postalCodeField)
                textFieldWithTitle(Constants.enterHere, text: $vm.phone, title: "\(Constants.phone) (\(Constants.optional))", focusStateField: .phoneField)
            }
            .textFieldStyle(.roundedBorder)
            shippingMethod
        }
    }
    
    private var paymentSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(Constants.payment)
                .font(AppFont.medium.font(size: 15))
                .foregroundStyle(AppColor.blackColor)
            
            Text(Constants.allPaymentsAreSecureAndEncryped)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.darkGrayTextColor)
            
            Button(action: {
                vm.startApplePay()
            }) {
                HStack {
                    Image(.apple)
                    Text(Constants.pay)
                        .font(AppFont.medium.font(size: 15))
                        .foregroundStyle(AppColor.whiteColor)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppColor.blackColor)
                .foregroundColor(AppColor.whiteColor)
                .cornerRadius(5)
            }
            
            HStack {
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                Text(Constants.orPayWithCard)
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.darkGrayTextColor)
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
            }
            .padding(.vertical, 20)

            
            shippingDetails
        }
        .padding(0)
    }
    
    private var shippingDetails: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // MARK: - Email
            textFieldWithTitle(Constants.enterHere, text: $vm.email, title: Constants.email, focusStateField: .emailField)
            
            // MARK: - Shipping Details
            Text(Constants.shippingDetails)
                .font(AppFont.bold.font(size: 15))
                .foregroundStyle(AppColor.blackColor)
            Text(Constants.cardInformation)
                .font(AppFont.medium.font(size: 13))
                .foregroundStyle(AppColor.blackColor)

            VStack(spacing: 0) {
                TextField(Constants.name, text: $vm.name)
                    .focused($focusedField, equals: .nameField)
                    .padding()
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                dropdownField("United States")
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                TextField(Constants.address, text: $vm.address)
                    .focused($focusedField, equals: .addressField)
                    .padding()
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)
            }
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(AppColor.borderColor))
            
            Text(Constants.enterAddressManually)
                .underline()
                .font(AppFont.regular.font(size: 11))
                .foregroundStyle(AppColor.darkGrayTextColor)
            
            // MARK: - Payment Details
            sectionHeader(Constants.paymentDetails)
            
            Text(Constants.cardInformation)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.darkGrayTextColor)
            VStack(spacing: 0) {
                cardNumberField
                 Divider()
                HStack(spacing: 0) {
                    TextField(Constants.mmyy, text: $vm.expiry)
                        .font(AppFont.regular.font(size: 13))
                        .foregroundStyle(AppColor.blackColor)
                        .keyboardType(.numberPad)
                        .onChange(of: vm.expiry) { oldValue,newValue in
                            vm.expiry = TextFieldFormatter.formatExpiry(newValue)
                            vm.validateExpiry()
                        }
                        .allowsHitTesting(false)
                        .padding()
                    Divider()
                    TextField(Constants.cvc, text: $vm.cvc)
                        .font(AppFont.regular.font(size: 13))
                        .foregroundStyle(AppColor.blackColor)
                        .keyboardType(.numberPad)
                        .padding()
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(AppColor.borderColor))
            
            // MARK: - Checkbox
            HStack {
                Image(systemName: vm.isBillingSame ? "checkmark.square.fill" : "square")
                    .onTapGesture {
                        vm.isBillingSame.toggle()
                    }
                Text(Constants.billingAddressIsSameAsShipping)
                    .font(.system(size: 14))
            }
            
        }
    }
    
    private var payButton: some View {
        Button(action: {
            vm.startApplePay()
        }) {
            Text("\(Constants.pay) \(vm.totalPrice)")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(5)
        }
    }
    

    private func sectionHeader(_ text: String) -> some View {
        Text(text)
            .font(AppFont.bold.font(size: 15))
            .foregroundStyle(AppColor.blackColor)
    }
    
    private func textFieldWithTitle(_ placeholder: String, text: Binding<String>, title: String, focusStateField: Field) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(AppFont.medium.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
            TextField(Constants.enterHere, text: text)
                .textFieldStyle(.plain)
                .focused($focusedField, equals: focusStateField)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
                .padding()
                .background(AppColor.lightGrayColor)
                .cornerRadius(5)
        }
    }

    private func dropdownField(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
            Spacer()
            Image(.downArrow)
        }
        .padding()
    }

    private var cardNumberField: some View {
        HStack {
            TextField("1234 1234 1234 1234", text: $vm.cardNumber)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(vm.cardError != nil ? AppColor.mediumRedColor : AppColor.darkGrayTextColor)
                .keyboardType(.numberPad)
                        .onChange(of: vm.cardNumber) { newValue in
                            vm.cardNumber = TextFieldFormatter.formatCardNumber(newValue)
                            vm.validateCard()
                        }
                        .cornerRadius(5)
            HStack(spacing: 5) {
                Image("visa")
                Image("mastercard")
                Image("amex")
            }
        }
        .padding()
        .background(AppColor.clearColor)
        .cornerRadius(0)
    }
}

#Preview {
    BuyNowView()
}
