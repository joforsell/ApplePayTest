//
//  Donation.swift
//  ApplePayTest
//
//  Created by Johan Forsell on 2022-08-14.
//

import Foundation

struct Donation: Identifiable {
    let id = UUID()
    let name: String
    let amount: String
}
