//
//  ApplePayButtonView.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//

import PassKit
import SwiftUI

struct ApplePayButtonView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> PKPaymentButton {
        return PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
    }
    
    func updateUIView(_ uiView: PKPaymentButton, context: Context) {}
}
