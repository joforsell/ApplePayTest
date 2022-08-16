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
            Text("Make a donation to your favourite developer!")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding()
                .padding(.top, 40)
            Spacer()
            HStack(spacing: 20) {
                ForEach(Donation.examples) { donation in
                    VStack {
                        VStack {
                            Image(donation.imageName)
                                .resizable()
                                .scaledToFill()
                        }
                        .frame(maxHeight: 80)
                        .frame(width: 100)
                        .foregroundColor(.black)
                        .background(vm.donation == donation ? Color.appOrange.cornerRadius(20).padding(2) : Color.appYellow.cornerRadius(20).padding(2))
                        .scaleEffect(vm.donation == donation ? 1.2 : 1)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                if vm.donation == donation {
                                    vm.donation = nil
                                } else {
                                    vm.donation = donation
                                }
                            }
                        }
                        VStack {
                            Text(donation.name)
                            Text(donation.amount.formatted() + " kr")
                                .font(.caption)
                        }
                        .padding()
                    }
                }
            }
            Spacer()
            ApplePayButton {
                vm.pressPay()
            }
            .padding()
            .disabled(vm.donation == nil)
            .opacity(vm.donation == nil ? 0.4 : 1)
        }
        .sheet(isPresented: $vm.transactionSucceeded, onDismiss: {
            withAnimation {
                vm.donation = nil
            }
        }) {
            DonationView(donation: vm.donation)
        }
    }
}
