//
//  PaymentManager.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//

import PassKit

class PaymentManager: NSObject, PKPaymentAuthorizationViewControllerDelegate {
    
    static let shared = PaymentManager()
    
    func startPayment() {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "your.merchant.id"
        request.supportedNetworks = [.visa, .masterCard]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "CA"
        request.currencyCode = "CAD"
        
        request.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "140"))
        ]
        
        guard let controller = PKPaymentAuthorizationViewController(paymentRequest: request) else { return }
        controller.delegate = self
        
        UIApplication.shared.windows.first?.rootViewController?.present(controller, animated: true)
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true)
    }
}
