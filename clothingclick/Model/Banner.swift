//
//  Banner.swift
//  clothingclick
//
//  Created by DavidBisht on 23/04/26.
//

import SwiftUI

struct Banner: Identifiable {
    let id: String
    let imageUrl: String
    let redirectUrl: String
    let title: String?
}

extension Banner {
    static let sample: [Banner] = [
    Banner(id: "1", imageUrl: "https://sp.yimg.com/ib/th/id/OIP.Xe0sUbF5Jt7xcd0ALSTHIAHaLH?pid=Api&w=148&h=148&c=7&rs=1", redirectUrl: "", title: "Top"),
    Banner(id: "2", imageUrl: "https://tse3.mm.bing.net/th/id/OIP.OCpf2WiTAggoe5YvEY7mHgHaHQ?pid=Api&P=0&h=220", redirectUrl: "", title: "Top"),
    Banner(id: "3", imageUrl: "https://tse1.mm.bing.net/th/id/OIP.2XmDu1JcbGtamNWztwuPGAHaHa?pid=Api&P=0&h=220", redirectUrl: "", title: "Top"),
    Banner(id: "4", imageUrl: "https://tse4.mm.bing.net/th/id/OIP.kMaxKYbMQ-VYjrNGXkaeFAHaLH?pid=Api&P=0&h=220", redirectUrl: "", title: "Footware")]
}
