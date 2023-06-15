//
//  Dashboard.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/15/23.
//

import SwiftUI


struct Dashboard: View {
    @EnvironmentObject private var authModel: AuthViewModel
    var body: some View {
        VStack {
        Text("\(authModel.user?.email ?? "")")
        }.toolbar {
        ToolbarItemGroup(placement: .navigationBarLeading) { Button(
        action: { authModel.signOut()
        }, label: {
        Text("Sign Out") .bold()
        })
        }
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
            .environmentObject(AuthViewModel())
    }
}
