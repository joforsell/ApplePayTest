//
//  ApplePayViewModel.swift
//  ApplePayTest
//
//  Created by Johan Forsell on 2022-08-14.
//

import Foundation

class ApplePayViewModel: ObservableObject {
    @Published var transactionSucceeded: Bool = false
    @Published var donation: Donation?
    
    let paymentHandler: PaymentHandling
    
    init(paymentHandler: PaymentHandling = PaymentHandler()) {
        self.paymentHandler = paymentHandler
    }
    
    func pressPay() {
        paymentHandler.startPayment(for: donation) { [weak self] success in
            if success {
                self?.transactionSucceeded = true
            }
        }
    }
}
