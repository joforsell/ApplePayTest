//
//  ContentView.swift
//  ApplePayTest
//
//  Created by Johan Forsell on 2022-08-14.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ApplePayViewModel()
    
    private let radius: CGFloat = 20
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 20) {
                ForEach(Donation.examples) { donation in
                    VStack {
                        Text(donation.name)
                        Text(donation.amount)
                    }
                    .frame(maxHeight: 80)
                    .frame(width: 100)
                    .foregroundColor(.white)
                    .background(vm.donation == donation ? Color.black : Color.gray)
                    .scaleEffect(vm.donation == donation ? 1.2 : 1)
                    .cornerRadius(20)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            vm.donation = donation
                        }
                    }
                }
            }
            Spacer()
            ApplePayButton {
                vm.paymentHandler.startPayment(for: vm.donation) { success in
                    if success {
                        vm.transactionSucceeded = true
                    }
                }
            }
            .padding()
            .disabled(vm.donation == nil)
            .opacity(vm.donation == nil ? 0.4 : 1)
        }
        .sheet(isPresented: $vm.transactionSucceeded, onDismiss: { vm.donation = nil }) {
            DonationView(donation: vm.donation)
        }
    }
}
