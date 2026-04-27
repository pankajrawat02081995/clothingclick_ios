//
//  FollowersViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//

import SwiftUI
import Combine

enum FollowStatus: String, CaseIterable, Identifiable {
    case following
    case followers
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .following: return "Following"
        case .followers: return "Followers"
        }
    }
}
class FollowersViewModel: ObservableObject {
    
    @Published var users: [User] = [
        User(name: "Justin Levin", username: "", followers: 23, isFollowing: false, image: "p1"),
        User(name: "Davis Kenter", username: "", followers: 23, isFollowing: true, image: "p2"),
        User(name: "Charlie Rosser", username: "", followers: 23, isFollowing: false, image: "p3")
    ]
    
    @Published var filterUsers: [User] = []
        
    @Published var selectedTab: FollowStatus = .followers
    
    
    @Published var search = ""
        
    func toggleFollow(_ user: User) {
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index].isFollowing.toggle()
        }
    }
    
    func searchUser() {
        guard search.isEmpty == false else {
            return
        }
        filterUsers = users.filter({$0.name.contains(search)})
    }
}
