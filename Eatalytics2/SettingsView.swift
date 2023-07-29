//
//  SettingsView.swift
//  Eatalytics2
//
//  
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    var body: some View {
        VStack {
            Text("\(authModel.user?.email ?? "")")
            Spacer()
            Button(action: {
                authModel.signOut()
            }, label: {
                Text("Sign Out").bold()
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
