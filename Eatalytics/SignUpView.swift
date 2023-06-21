//
//  Signup.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/15/23.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @EnvironmentObject private var authModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Create Account")
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
                    signUp()
                }) {
                    Text("Sign Up")
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
                
                NavigationLink(destination: SignInView().navigationBarHidden(true)) {
                    Text("Already have an account? Sign In")
                        .foregroundColor(Color("Dark"))
                        .fontWeight(.bold)
                        .font(.custom("Inter", fixedSize: 14))
                        .foregroundColor(.white)
                        .padding(.vertical, 20.0)
                }
                
                Text(errorMessage)
                    .foregroundColor(Color("Dark"))
                
                Spacer()
            }
            .padding(.vertical, 40)
            .background(Color("Light").ignoresSafeArea())
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                authModel.user = authResult?.user // Set the user in AuthViewModel
                authModel.isSigningUp = true // Set isSigningUp to true for navigation
                
                // Reset email and password fields
                email = ""
                password = ""
            }
        }
    }


}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
