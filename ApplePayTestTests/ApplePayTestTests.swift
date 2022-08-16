//
//  ApplePayTestTests.swift
//  ApplePayTestTests
//
//  Created by Johan Forsell on 2022-08-14.
//

import XCTest
import PassKit
@testable import ApplePayTest

class ApplePayVMTests: XCTestCase {
    
    func testSuccessfulAuthorization_setsTransactionSuccessStateToTrue() throws {
        
        let handler = MockPaymentHandler(successfullyAuthorizing: true)
        let vm = ApplePayViewModel(paymentHandler: handler)
        
        vm.pressPay()
        
        XCTAssertTrue(vm.transactionSucceeded)
        
    }
    
    func testUnsuccessfulAuthorization_setsTransactionSuccessStateToFalse() throws {
        
        let handler = MockPaymentHandler(successfullyAuthorizing: false)
        let vm = ApplePayViewModel(paymentHandler: handler)
        
        vm.pressPay()
        
        XCTAssertFalse(vm.transactionSucceeded)
        
    }
    
}

class PaymentHandlerTests: XCTestCase {
    
    let handler = PaymentHandler()
    
    func testPaymentWithDonation_correctlyCalculatesAmounts() throws {
        
        let donation = Donation(name: "Pizza", amount: 100, imageName: "pizza")
        
        handler.startPayment(for: donation, completion: { _ in })
        
        XCTAssertEqual(PKPaymentSummaryItem(label: "Pizza", amount: NSDecimalNumber(string: "100")), handler.paymentSummaryItems[0])
        XCTAssertEqual(PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(string: "20")), handler.paymentSummaryItems[1])
        XCTAssertEqual(PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "120")), handler.paymentSummaryItems[2])
        
    }
    
}
