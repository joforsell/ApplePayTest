//
//  ApplePayButton.swift
//  ApplePayTest
//
//  Created by Johan Forsell on 2022-08-14.
//

import Foundation
import SwiftUI
import PassKit

struct ApplePayButton: View {
    var action: () -> Void
        
    var body: some View {
        Representable(action: action)
            .frame(minWidth: 100, maxWidth: 400)
            .frame(height: 45)
            .frame(maxWidth: .infinity)
    }
}

extension ApplePayButton {
    struct Representable: UIViewRepresentable {
        var action: () -> Void
        
        func makeUIView(context: Context) -> some UIView {
            context.coordinator.button
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(action: action)
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            context.coordinator.action = action
        }
    }
    
    class Coordinator: NSObject {
        var action: () -> Void
        var button = PKPaymentButton(paymentButtonType: .donate, paymentButtonStyle: .automatic)
        
        init(action: @escaping () -> Void) {
            self.action = action
            super.init()
            
            button.addTarget(self, action: #selector(callback(_:)), for: .touchUpInside)
        }
        
        @objc
        func callback(_ sender: Any) {
            action()
        }
    }
}
