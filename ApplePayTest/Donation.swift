//
//  Donation.swift
//  ApplePayTest
//
//  Created by Johan Forsell on 2022-08-14.
//

import Foundation

struct Donation: Identifiable, Equatable {
    let id: String = UUID().uuidString
    let name: String
    let amount: Double
    let imageName: String
    
    static let examples = [
        Donation(name: "Coffee", amount: 30, imageName: "coffeecup"),
        Donation(name: "Pizza", amount: 100, imageName: "pizza"),
        Donation(name: "Fancy dinner", amount: 300, imageName: "lobster")
    ]
}
