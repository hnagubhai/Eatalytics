//
//  AuthViewModel.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/15/23.
//

import SwiftUI
import FirebaseAuth

final class AuthViewModel: ObservableObject {
    @Published var user: User? // Use @Published instead of objectWillChange.send()
    @Published var isSigningUp = false // Track sign-up state
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            self.user = user
        }
    }
    
    func signUp(emailAddress: String, password: String) {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                print("An error occurred: \(error.localizedDescription)")
                return
            }
            
            self.user = result?.user // Set the user
            
            // Set isSigningUp to false to handle navigation in the view
            self.isSigningUp = false
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

