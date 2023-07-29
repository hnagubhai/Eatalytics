//
//  Signup.swift
//  Eatalytics
//
//  
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

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
            } else if let user = authResult?.user {
               
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(user.uid)
                
                
                let createdAtTimestamp = Timestamp(date: Date())
                userRef.setData([
                    "email": user.email ?? "",
                    "createdAt": createdAtTimestamp
                ]) { error in
                    if let error = error {
                        
                        errorMessage = "Error creating user document: \(error.localizedDescription)"
                    } else {
                       
                        authModel.user = user
                        errorMessage = ""
                        
                        
                        let itemsCollectionRef = userRef.collection("items")
                        
                        
                        let defaultItem = [
                            "taskDate": createdAtTimestamp,
                            "taskTitle": "Default",
                            "taskDescription": "Null"
                        ]
                        
                       
                        itemsCollectionRef.addDocument(data: defaultItem) { error in
                            if let error = error {
                               
                                print("Error creating default item: \(error.localizedDescription)")
                            } else {
                                
                                print("Default item added successfully")
                            }
                        }
                        
                     
                        email = ""
                        password = ""
                    }
                }
            }
        }
    }





}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
