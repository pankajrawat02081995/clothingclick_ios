//
//  Constants.swift
//  clothingclick
//
//  Created by DavidBisht on 20/04/26.
//

import Foundation
import SwiftUI

struct Constants {
    static let landingViewTitle = "What are you shopping\nfor?"
    static let landingViewSubTitle = "Set your preferences to personalize your experience."
    static let next = "Next"
    static let selectSizes = "Select Sizes"
    static let menswear = "Menswear"
    static let womenswear = "Womenswear"
    static let both = "Both"
    static let tops = "Tops"
    static let bottoms = "Bottoms"
    static let footwear = "Footwear"
    static let outerwear = "Outerwear"
    static let allowAccess = "Allow Access"
    static let loacationPermissionSubTitle = "Turn on your device location services to use Clothing Click."
    static let turnOnLocation = "Turn on Location"
    static let openSettings = "Open Settings"
    static let locationAccessGranted = "Location Access Granted"
    static let AppName = "ClothingClick"
    static let notifications = "Notifications"
    static let confirm = "Confirm"
    static let delete = "Delete"
    static let locationViewTitle = "Your address will never be shared"
    static let addressOrPostalCode = "Address or Postal Code"
    static let save = "Save"
    static let location = "Location"
    static let seller = "Seller"
    static let reviews = "Reviews"
    static let posts = "Posts"
    static let recentlyViewed = "Recently Viewed"
    static let moreFromSeller = "More from seller"
    static let viewOnMap = "View on Map"
    static let chat = "Chat"
    static let buyNow = "Buy Now"
    static let size = "Size"
    static let condition = "Condition"
    static let delivery = "Delivery"
    static let pay = "Pay"
    static let allPaymentsAreSecureAndEncryped = "All payments are secure and encryped"
    static let payment = "Payment"
    static let orPayWithCard = "Or pay with card"
    static let email = "Email"
    static let name = "Name"
    static let enterHere = "Enter here"
    static let shippingDetails = "Shipping Details"
    static let cardInformation = "Card Information"
    static let address = "Address"
    static let enterAddressManually = "Enter address manually"
    static let paymentDetails = "Payment Details"
    static let mmyy = "MM/YY"
    static let cvc = "CVC"
    static let billingAddressIsSameAsShipping = "Billing address is same as shipping"
    static let addressesAreSecureAndEncrypted = "Addresses are secure and encrypted"
    static let countryRegion = "Country/Region"
    static let dscvdvds = "Enter here"
    static let firstName = "First Name"
    static let lastName = "Last Name"
    static let city = "City"
    static let state = "State"
    static let postalCode = "Postal Code"
    static let pickupLocation = "Pickup Location"
    static let phone = "Phone"
    static let optional = "Optional"
    static let company = "Company"
    static let apartmentEtc = "Apartment, suite, etc."
    static let province = "Province"
    static let shippingMethod = "Shipping method"
    static let standard = "Standard"
    static let businessDays = "business days"
    static let to = "to"
    static let category = "Category"
    static let followers = "Followers"
    static let following = "Following"
    static let follow = "Follow"
    static let searchProfiles = "Search Profiles"
}

struct AppColor {
    static let whiteColor: Color = Color("WhiteColor")
    static let blackColor: Color = Color("BlackColor")
    static let blueColor: Color = Color("BlueColor")
    static let darkGrayColor: Color = Color("DarkGrayColor")
    static let grayColor: Color = Color("GrayColor")
    static let lightGrayColor: Color = Color("LightGrayColor")
    static let greenColor: Color = Color("GreenColor")
    static let lightGreenColor: Color = Color("lightGreenColor")
    static let redColor: Color = Color("RedColor")
    static let mediumRedColor: Color = Color("MediumRedColor")
    static let grayTabColor: Color = Color("GrayTabColor")
    static let borderColor: Color = Color("BorderColor")
    static let clearColor: Color = Color(.clear)
    static let grayTextColor: Color = Color("GrayTextColor")
    static let darkGrayTextColor: Color = Color("DarkGrayTextColor")
    static let brownGrayColor: Color = Color("BrownGrayColor")
}

enum CategoryType: String {
    case both = "Both"
    case menswear = "Menswear"
    case womenswear = "Womenswear"
}

enum DashboardTab: Hashable {
    case home
    case discover
    case sell
    case messages
    case account
}
