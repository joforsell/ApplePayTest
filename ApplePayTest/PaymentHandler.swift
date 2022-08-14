//
//  PaymentHandler.swift
//  ApplePayTest
//
//  Created by Johan Forsell on 2022-08-14.
//

import Foundation
import PassKit

typealias PaymentCompletionHandler = (Bool) -> Void

class PaymentHandler: NSObject {
    
    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler!
    
    static let supportedNetworks: [PKPaymentNetwork] = [
        .masterCard,
        .visa
    ]
    
    class func applePayStatus() -> (canMakePayments: Bool, canSetupCards: Bool) {
        return (PKPaymentAuthorizationController.canMakePayments(),
                PKPaymentAuthorizationController.canMakePayments(usingNetworks: supportedNetworks))
    }
    
    func startPayment(for donation: Donation, completion: @escaping PaymentCompletionHandler) {
        completionHandler = completion
        
        let taxAmount = calculateTax(for: donation.amount)
        let totalAmount = calculateTotal(for: donation.amount)
        
        let donation = PKPaymentSummaryItem(label: donation.name, amount: NSDecimalNumber(string: donation.amount))
        let tax = PKPaymentSummaryItem(label: "Skatt", amount: NSDecimalNumber(string: taxAmount))
        let total = PKPaymentSummaryItem(label: "Totalsumma", amount: NSDecimalNumber(string: totalAmount))
        paymentSummaryItems = [donation, tax, total]
        
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.merchantIdentifier = Configuration.Merchant.identifier
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "SE"
        paymentRequest.currencyCode = "SEK"
        paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
        
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present { presented in
            if presented {
                debugPrint("Presented payment controller")
            } else {
                debugPrint("Failed to present payment controller")
                self.completionHandler(false)
            }
        }
    }
    
    private func calculateTax(for donationAmount: String) -> String {
        guard let amount = Double(donationAmount) else { return "" }
        return String(amount * 0.2)
    }
    
    private func calculateTotal(for donationAmount: String) -> String {
        guard let amount = Double(donationAmount) else { return "" }
        let tax = amount * 0.2
        return String(amount + tax)
    }
}

extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let errors = [Error]()
        let status = PKPaymentAuthorizationStatus.success
        self.paymentStatus = status
        completion(PKPaymentAuthorizationResult(status: status, errors: errors))
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            DispatchQueue.main.async {
                if self.paymentStatus == .success {
                    self.completionHandler!(true)
                } else {
                    self.completionHandler!(false)
                }
            }
        }
    }
}
