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
}

struct AppColor {
    static let whiteColor: Color = Color("WhiteColor")
    static let blackColor: Color = Color("BlackColor")
    static let blueColor: Color = Color("BlueColor")
    static let darkGrayColor: Color = Color("DarkGrayColor")
    static let grayColor: Color = Color("GrayColor")
    static let lightGrayColor: Color = Color("lightGrayColor")
    static let greenColor: Color = Color("GreenColor")
    static let lightGreenColor: Color = Color("lightGreenColor")
    static let redColor: Color = Color("RedColor")
    static let mediumRedColor: Color = Color("MediumRedColor")
    static let grayTabColor: Color = Color("GrayTabColor")
    static let borderColor: Color = Color("BorderColor")
    static let clearColor: Color = Color(.clear)
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



//Colors Refernece
//  filename: BlackColor.colorset
//
//  filename: BlueColor.colorset
//
//  filename: BorderColor.colorset
//  E9E9E9

//  filename: DarkGrayColor.colorset
//
//  filename: GrayColor.colorset
//
//  filename: GrayTabColor.colorset
//
//  filename: GreenColor.colorset
//
//  filename: LightGrayColor.colorset
//
//  filename: LightGreenColor.colorset
//
//  filename: MediumRedColor.colorset
//
//  filename: RedColor.colorset
//
//  filename: WhiteColor.colorset
