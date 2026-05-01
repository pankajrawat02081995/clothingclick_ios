//
//  ColorViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import Combine

class ColorViewModel: ObservableObject {
    @Published var colors: [ColorDetail] = []
    
}

extension ColorViewModel {
    func mockData() {
        colors = [
            ColorDetail(id: "1", hexCode: "#000000", name: "Black"),
            ColorDetail(id: "2", hexCode: "#808080", name: "Grey"),
            ColorDetail(id: "3", hexCode: "#FFFFFF", name: "White"),
            ColorDetail(id: "4", hexCode: "#FF8C00", name: "Orange"),
            ColorDetail(id: "5", hexCode: "#FF0000", name: "Red"),
            ColorDetail(id: "6", hexCode: "#0000FF", name: "Blue"),
            ColorDetail(id: "7", hexCode: "#00C853", name: "Green"),
            ColorDetail(id: "8", hexCode: "#FFEA00", name: "Yellow"),
            ColorDetail(id: "9", hexCode: "#8B4513", name: "Brown"),
            ColorDetail(id: "10", hexCode: "#FF66FF", name: "Pink"),
            ColorDetail(id: "11", hexCode: "#F5DEB3", name: "Beige"),
            ColorDetail(id: "12", hexCode: "#8A2BE2", name: "Purple"),
            ColorDetail(id: "13", hexCode: "#6B8E23", name: "Camo"),
            ColorDetail(id: "14", hexCode: "#FF69B4", name: "Multicolor & Tyedye")
        ]
    }
}
