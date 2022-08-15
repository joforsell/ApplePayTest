//
//  Double+FormattedString.swift
//  ApplePayTest
//
//  Created by Johan Forsell on 2022-08-15.
//

import Foundation

extension Double {
    func formatted() -> String {
        return String(format: "%.0f", self)
    }
}
