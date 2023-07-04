//
//  ViewHandler.swift
//  Eatalytics2
//
//  Created by Hemanth Nagubhai on 7/3/23.
//

import SwiftUI

struct ViewHandler: View {
    @EnvironmentObject private var authModel: AuthViewModel
    var body: some View {
        Group {
            if authModel.user != nil {
                ContentView()
            } else {
                Onboarding_1()
            }
        }
        .onAppear {
            authModel.listenToAuthState()
        }
    }
}

struct ViewHandler_Previews: PreviewProvider {
    static var previews: some View {
        ViewHandler()
    }
}
