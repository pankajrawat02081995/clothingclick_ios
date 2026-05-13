//
//  StoreDayModel.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import Foundation

struct StoreDayModel: Identifiable {
    let id = UUID()
    let day: String
    var openingTime: String = ""
    var openingPeriod: TimePeriod = .am
    var closingTime: String = ""
    var closingPeriod: TimePeriod = .pm
}

enum TimePeriod: String, CaseIterable {
    case am = "AM"
    case pm = "PM"
}
