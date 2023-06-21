//
//  Welcome.swift
//  Eatalytics
//
//  Created by Manas Jain on 6/15/23.
//


import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if let user = authModel.user {
                    if authModel.isSigningUp {
                        SetAGoal()
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true)
                    } else {
                        Dashboard()
                           // .navigationBarBackButtonHidden(true)
                           // .navigationBarHidden(true)
                    }
                } else {
                    WelcomeContent()
                }
            }
            .onAppear {
                authModel.listenToAuthState()
            }
        }
    }
}




struct WelcomeContent: View {
    var body: some View {
        VStack(spacing: 50) {
            Spacer()
            
            HStack {
                Spacer()
                
                Text("WELCOME TO EATALYTICS")
                    .fontWeight(.heavy)
                    .foregroundColor(Color("Green"))
                    .multilineTextAlignment(.leading)
                    .font(.custom("Urbanist", fixedSize: 55))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 5)
                    .lineLimit(5)
                    .lineSpacing(20)
                    .minimumScaleFactor(0.5) // Adjust the scale factor as needed
            }
            
            Spacer()
            
            HStack {
                Spacer()
                NavigationLink(destination: Onboarding_1()) {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 24))
                        .foregroundColor(Color("Dark"))
                        .padding(.all, 30.0)
                        .background(Color("Light"))
                        .clipShape(Circle())
                }
            }
            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            .padding(.horizontal)
        }
        .padding()
        .navigationBarHidden(true)
        .background(Color("Dark").ignoresSafeArea())
    }
}




