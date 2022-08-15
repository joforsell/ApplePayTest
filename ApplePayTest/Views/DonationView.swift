//
//  DonationView.swift
//  ApplePayTest
//
//  Created by Johan Forsell on 2022-08-15.
//

import SwiftUI

struct DonationView: View {
    let donation: Donation?
    
    @State private var animating = false
    
    var body: some View {
        VStack {
            Text("Thank you for your donation!")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding()
            Image(donation!.imageName)
                .resizable()
                .scaledToFit()
                .padding(40)
                .background {
                    Star(corners: 8, smoothness: 0.65)
                        .frame(maxWidth: .infinity)
                        .scaledToFit()
                        .padding()
                        .foregroundColor(.appYellow)
                        .opacity(0.5)
                        .rotationEffect(animating ? .degrees(0) : .degrees(360))
                }
            Text(donation!.amount.formatted() + " kr")
                .font(.title)
        }
        .onAppear {
            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                animating.toggle()
            }
        }
    }
}
