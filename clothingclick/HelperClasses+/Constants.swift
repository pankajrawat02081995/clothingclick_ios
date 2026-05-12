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
    static let contacts = "Contacts"
    static let privateAccount = "Private Account"
    static let followThisAccountToSeeTheirListings = "Follow this account to see their listings"
    static let seeAll = "See all"
    static let searchProductsAndProfiles = "Search Products & Profiles"
    static let searchWithDots = "Search..."
    static let filter = "Filter"
    static let results = "Results"
    static let view = "View"
    static let result = "Result"
    static let clearAll = "Clear all"
    static let style = "Style"
    static let popularBrand = "Popular Brand"
    static let brand = "Brand"
    static let colors = "Colors"
    static let searchDesignersAndBrandNames = "Search Designers & Brand Names"
    static let department = "Department"
    static let accessories = "Accessories"
    static let jeans = "Jeans"
    static let selectLocation = "Select Location"
    static let sell = "Sell"
    static let messages = "Messages"
    static let account = "Account"
    static let home = "Home"
    static let discover = "Discover"
    static let createNewSavedSearch = "Create new saved search"
    static let viewSavedSearches = "View saved searches"
    static let savedSearches = "Saved searches"
    static let cancel = "Cancel"
    static let notifyMeWhenNewItemsAreListed = "Notify me when new items are listed"
    static let titleOfSearch = "Title of search"
    static let noResultsFound = "No results found"
    static let spaceDotSpaceSeen = " . Seen"
    static let typeHere = "Type here"
    static let selectRadius = "Select Radius"
    static let km = "km"
    static let distance = "Distance"
    static let color = "Color"
    static let preview = "Preview"
    static let post = "Post"
    static let photos = "Photos"
    static let guide = "Guide"
    static let brandName = "Brand Name"
    static let title = "Title"
    static let price = "Price"
    static let description = "Description"
    static let cover = "Cover"
    static let addPhotos = "Add Photos"
    static let details = "Details"
    static let photoGuide = "Photo guide"
    static let gotIt = "Got it"
    
    static let guideCoverPhotoTitle = "Cover Photo: Front view of product"
    static let guideCoverPhotoDescription = "Capture the front of your item against a clean background. We recommend the PhotoRoom app for editing with a white backdrop."
    
    static let guideMorePhotosTitle = "The more photos, the better!"
    static let guideMorePhotosDescription = "Add up to 9 photos or add a video. Include a full-length view, fine details, and the item being worn. More details means fewer questions from buyers, and quicker sales."
    
    static let indicateTheFlawsTitle = "Indicate the flaws"
    static let indicateTheFlawsDescription = "Show where your item exhibits any imperfections. Honesty is always appreciated, and is hands down the best policy."
    
    static let brandTagRecommendedTitle = "Brand tag (recommended)"
    static let brandTagRecommendedTitleDescription = "Most fashion items have a brand tag. This usually includes the brands logo. If one is present, please provide a clear photo. "
    
    static let packaginPhotosTitle = "Packaging photos"
    static let packaginPhotosDescription = "Displaying any original packaging you have (ie. boxes and dust bags) increase your items selling price and  desirability."
    
    static let sneakersFootwearPhotoGuideTitle = "Sneakers / footwear photo guide"
    static let sneakersFootwearPhotoGuideDescription = "Footwear listings should include photos of the size label inside. This aids in authenticity and offers relevant details to interested buyers."
    
    static let outSoleTitle = "Out sole"
    static let outSoleDescription = "Add a clear photo of the bottom of the shoes. This helps with authentication and provides useful information to the buyer about the condition of the item. "
    

    static let done = "Done"
    static let ok = "Ok"
}

struct AppColor {
    static let whiteColor: Color = Color("WhiteColor")
    static let blackColor: Color = Color("BlackColor")
    static let blueColor: Color = Color("BlueColor")
    static let darkGrayColor: Color = Color("DarkGrayColor")
    static let grayColor: Color = Color("GrayColor")
    static let lightGrayColor: Color = Color("LightGrayColor")
    static let greenColor: Color = Color("GreenColor")
    static let lightGreenColor: Color = Color("LightGreenColor")
    static let redColor: Color = Color("RedColor")
    static let mediumRedColor: Color = Color("MediumRedColor")
    static let grayTabColor: Color = Color("GrayTabColor")
    static let borderColor: Color = Color("BorderColor")
    static let clearColor: Color = Color(.clear)
    static let grayTextColor: Color = Color("GrayTextColor")
    static let darkGrayTextColor: Color = Color("DarkGrayTextColor")
    static let brownGrayColor: Color = Color("BrownGrayColor")
    
    static let defaultPlaceholderTextColor = Color(uiColor: .placeholderText)
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

enum Field: Hashable {
    case countryField
    case firstNameField
    case lastNameField
    case addressField
    case cityField
    case cardNumberField
    case stateField
    case postalCodeField
    
    case emailField
    case nameField
    case cardField
    case cvcField
    case expiryField
    case phoneField
    case companyField
    case apartmentField
    case provinceField
    
    case savedSearchItemsField
    case savedSearchTitleField
    
    //Sell Details
    
    case brandNameField
    case titleField
    case descriptionField
    case priceField
    case locationField
}
