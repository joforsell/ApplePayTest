//
//  MockPaymentHandler.swift
//  ApplePayTestTests
//
//  Created by Johan Forsell on 2022-08-16.
//

import Foundation
@testable import ApplePayTest

class MockPaymentHandler: PaymentHandling {
    let successfullyAuthorizing: Bool
    
    init(successfullyAuthorizing: Bool) {
        self.successfullyAuthorizing = successfullyAuthorizing
    }
    
    func startPayment(for donation: Donation?, completion: @escaping PaymentCompletionHandler) {
        completion(successfullyAuthorizing)
    }
    
    
}
