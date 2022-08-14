//
//  Donation.swift
//  ApplePayTest
//
//  Created by Johan Forsell on 2022-08-14.
//

import Foundation

struct Donation: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let amount: String
    
    static let examples = [
        Donation(name: "Kaffe", amount: "30"),
        Donation(name: "Pizza", amount: "100"),
        Donation(name: "Finmiddag", amount: "300")
    ]
}
