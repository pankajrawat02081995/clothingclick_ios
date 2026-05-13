//
//  EditStoreProfileViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import Combine
import SwiftUI

class EditStoreProfileViewModel: ObservableObject {
    
    @Published var storename: String = ""
    @Published var username: String = ""
    @Published var featurePhotos: [UIImage] = []
    @Published var bio: String = ""
    @Published var link: String = ""
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var storeProfilePicture: Image? = nil
    
}
