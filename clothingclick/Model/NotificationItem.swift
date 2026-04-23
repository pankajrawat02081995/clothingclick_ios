//
//  NotificationItem.swift
//  clothingclick
//
//  Created by DavidBisht on 22/04/26.
//

import SwiftUI

struct NotificationItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let subtitle: String
    let time: String
    let type: NotificationType
}

enum NotificationType {
    case normal
    case followRequest
    case priceDrop
}

extension NotificationItem {
    
    static let sampleData: [NotificationItem] = [
        NotificationItem(
            image: "p1",
            title: "Saved Search",
            subtitle: "A few listing matches your saved search.",
            time: "3h ago",
            type: .normal
        ),
        NotificationItem(
            image: "p2",
            title: "Custom message header",
            subtitle: "custom message subject",
            time: "3h ago",
            type: .normal
        ),
        NotificationItem(
            image: "p3",
            title: "Jenni Minal",
            subtitle: "Started following you.",
            time: "3h ago",
            type: .normal
        ),
        NotificationItem(
            image: "p4",
            title: "John4444",
            subtitle: "requested to follow you.",
            time: "3h ago",
            type: .followRequest
        ),
        NotificationItem(
            image: "p5",
            title: "Joshua rrr",
            subtitle: "Yeah I can meet at 4:30 no issue",
            time: "3h ago",
            type: .normal
        ),
        NotificationItem(
            image: "p6",
            title: "Price Drop",
            subtitle: "",
            time: "3h ago",
            type: .priceDrop
        )
    ]
}
