//
//  Signup.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/15/23.
//

import SwiftUI

struct Signup: View {
    @EnvironmentObject private var authModel: AuthViewModel
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Email", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .keyboardType(.default)
            }
            Section {
                Button(action: {
                    authModel.signUp(emailAddress: emailAddress, password: password)
                }) {
                    Text("Sign Up")
                        .bold()
                }
            }
        }
        .navigationTitle("Sign Up")
    }
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup()
            .environmentObject(AuthViewModel()) // Provide AuthViewModel as an environment object
    }
}
