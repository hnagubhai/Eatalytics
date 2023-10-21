//
//  AuthViewModel.swift
//  Eatalytics
//
//  
//

import SwiftUI
import FirebaseAuth

final class AuthViewModel: ObservableObject {
    @Published var user: User?
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            self.user = user
        }
    }
    
    func signUp(emailAddress: String, password: String, displayName: String) {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { result, error in
            if let error = error {
                print("An error occurred: \(error.localizedDescription)")
            } else {
                // Update user's display name
                if let user = Auth.auth().currentUser {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges { error in
                        if let error = error {
                            print("Failed to set display name: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
    
    func signIn(emailAddress: String, password: String) {
        Auth.auth().signIn(withEmail: emailAddress, password: password) { result, error in
            if let error = error {
                print("An error occurred: \(error.localizedDescription)")
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }
    
    func changeEmail(newEmail: String) {
        if let user = Auth.auth().currentUser {
            user.updateEmail(to: newEmail) { error in
                if let error = error {
                    print("Failed to change email: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func changePassword(newPassword: String) {
        if let user = Auth.auth().currentUser {
            user.updatePassword(to: newPassword) { error in
                if let error = error {
                    print("Failed to change password: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func changeDisplayName(newName: String) {
        if let user = Auth.auth().currentUser {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = newName
            changeRequest.commitChanges { error in
                if let error = error {
                    print("Failed to change display name: \(error.localizedDescription)")
                }
            }
        }
    }
}
