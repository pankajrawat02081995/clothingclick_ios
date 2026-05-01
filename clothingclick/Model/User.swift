//
//  User.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    let name: String
    let username: String
    let followers: Int
    var isFollowing: Bool
    let image: String
}

extension User {
    
    static let sample =
        User(name: "rahul", username: "aman22", followers: 22, isFollowing: false, image: "https://tse2.mm.bing.net/th/id/OIP.rnvQIFY2RGAq_0-jYFNwPAHaHa?pid=Api&h=220&P=0")
    
    static let mockData = [
        User(name: "aman", username: "aman22", followers: 22, isFollowing: false, image: "https://tse2.mm.bing.net/th/id/OIP.rnvQIFY2RGAq_0-jYFNwPAHaHa?pid=Api&h=220&P=0"),
        User(name: "darshan", username: "darshan23", followers: 22, isFollowing: false, image: ""),
        User(name: "rohit", username: "rohit22", followers: 22, isFollowing: true, image: "https://tse2.mm.bing.net/th/id/OIP.rnvQIFY2RGAq_0-jYFNwPAHaHa?pid=Api&h=220&P=0"),
        User(name: "ritik", username: "ritik22", followers: 22, isFollowing: true, image: "")
    ]
}
