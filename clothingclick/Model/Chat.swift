//
//  Chat.swift
//  clothingclick
//
//  Created by DavidBisht on 07/05/26.
//

import SwiftUI

struct Chat: Identifiable, Codable {
    let id: Int
    let message: String
    let date: String
    let isSeen: Bool
    let userId: Int
}

extension Chat {
    static let sampleChats: [Chat] = [
        Chat(id: 1, message: "Ultricies odio diam facilisis ultrices. Id ut mauris blandit eget leo feugiat in ut integer.", date: "12:30 AM", isSeen: false, userId: 23),
        Chat(id: 2, message: "Ultricies odio diam facilisis ultrices. Id ut mauris blandit eget leo feugiat in ut integer.", date: "12:30 AM", isSeen: true, userId: 45)
    ]
}
