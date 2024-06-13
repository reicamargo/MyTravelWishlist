//
//  AuthenticationScreen.swift
//  MyTravelWishlist
//
//  Created by Reinaldo Camargo on 13/06/24.
//

import LocalAuthentication
import SwiftUI

struct AuthenticationScreen: View {
    @Binding var needAuthentication: Bool
    @State var errorMessage = ""
    
    var body: some View {
        ZStack {
            Image(.mtwLogo)
                .aspectRatio(contentMode: .fill)
            Color.white.opacity(0.6)
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Text(errorMessage)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .foregroundStyle(.red)
                    .padding(6)
                    .background(.white.opacity(0.6))
                Spacer()
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to identify you to make your data protected."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    needAuthentication = false
                } else {
                    errorMessage = "You need to allow biometrics to authenticate."
                }
            }
            
        } else {
            //no biometrics
            errorMessage = "Biometrics is necessary to use this app..."
        }
    }
}

#Preview {
    AuthenticationScreen(needAuthentication: .constant(true))
}
