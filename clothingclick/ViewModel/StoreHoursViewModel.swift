//
//  StoreHoursViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import Combine

final class StoreHoursViewModel: ObservableObject {

    @Published var isTemporarilyClosed: Bool = false
    @Published var isOpen: Bool = true

    @Published var storeDays: [StoreDayModel] = [
        StoreDayModel(day: "Monday"),
        StoreDayModel(day: "Tuesday"),
        StoreDayModel(day: "Wednesday"),
        StoreDayModel(day: "Thursday"),
        StoreDayModel(day: "Friday"),
        StoreDayModel(day: "Saturday"),
        StoreDayModel(day: "Sunday")
    ]

    func saveStoreHours() {
        print("Store hours saved")
    }
}
