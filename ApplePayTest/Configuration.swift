//
//  Configuration.swift
//  ApplePayTest
//
//  Created by Johan Forsell on 2022-08-14.
//

import Foundation

public class Configuration {

    private struct MainBundle {
        static var prefix: String = {
            guard let prefix = Bundle.main.object(forInfoDictionaryKey: "AAPLOfferingApplePayBundlePrefix") as? String else {
                return ""
            }
            return prefix
        }()
    }
    
    struct Merchant {
        static let identifier = "merchant.\(MainBundle.prefix).ApplePayTest"
    }
}
