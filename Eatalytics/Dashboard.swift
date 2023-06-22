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
            Text("\(authModel.user?.email ?? "")")
    }
    
    struct Dashboard_Previews: PreviewProvider {
        static var previews: some View {
            Dashboard()
                .environmentObject(AuthViewModel())
        }
    }
}
