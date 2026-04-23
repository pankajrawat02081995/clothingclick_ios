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
