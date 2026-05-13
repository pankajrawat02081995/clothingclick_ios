//
//  EditProfileViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import Combine
import SwiftUI

class EditProfileViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var bio: String = ""
    @Published var profilePicture: Image? = nil
    
}
