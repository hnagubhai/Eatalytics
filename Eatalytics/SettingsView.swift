//
//  SettingsView.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/22/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    var body: some View {
        VStack {
            Text("\(authModel.user?.email ?? "")")
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action: {
                    authModel.signOut()
                }, label: {
                    Text("Sign Out").bold()
                })
            }
        }
        .navigationTitle("Settings")
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
