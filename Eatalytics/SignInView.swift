//
//  Signin.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/15/23.
//

import SwiftUI
import Firebase

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome Back!")
                .fontWeight(.bold)
                .foregroundColor(Color("Dark"))
                .multilineTextAlignment(.leading)
                .font(.custom("Urbanist", fixedSize: 40))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .lineLimit(5)
                .minimumScaleFactor(0.5)
            
            TextField("Email", text: $email)
                .padding()
                .background(Color.white)
                .cornerRadius(30)
                .font(.body)
                .foregroundColor(Color("Dark"))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color("LightGray"), lineWidth: 1)
                )
                .padding(.horizontal)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.white)
                .cornerRadius(30)
                .font(.body)
                .foregroundColor(Color("Dark"))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color("LightGray"), lineWidth: 1)
                )
                .padding(.horizontal)
                .textContentType(.password)
            
            Button(action: {
                forgotPassword()
            }) {
                Text("Forgot Password?")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Green"))
                    .font(.custom("Urbanist", fixedSize: 14))
                    .padding(.leading, 245)
            }
            
            Button(action: {
                signIn()
            }) {
                Text("Sign In")
                    .foregroundColor(Color("Dark"))
                    .fontWeight(.semibold)
                    .font(.custom("Urbanist", fixedSize: 14))
                    .foregroundColor(.white)
                    .padding(.horizontal, 150)
                    .padding(.vertical, 20.0)
                    .background(Color("LightGreen"))
                    .clipShape(Capsule())
            }
            .padding(.horizontal)
            
            Text(errorMessage)
                .foregroundColor(Color("Dark"))
            
            Spacer()
        }
        .padding(.vertical, 40)
        .background(Color("Light").ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                print("Sign in successful")
            }
        }
    }
    
    func forgotPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                print("Password reset email sent")
            }
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
