//
//  DonationView.swift
//  ApplePayTest
//
//  Created by Johan Forsell on 2022-08-15.
//

import SwiftUI

struct DonationView: View {
    let donation: Donation?
    
    var body: some View {
        VStack {
            Text("Thank you for your donation!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Image("coffeecup")
                .padding()
            Text("\(donation!.amount) kr")
                .font(.title)
        }
    }
}
