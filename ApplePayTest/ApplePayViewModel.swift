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
    
    let paymentHandler: PaymentHandler
    
    init(paymentHandler: PaymentHandler = PaymentHandler()) {
        self.paymentHandler = paymentHandler
    }
}
