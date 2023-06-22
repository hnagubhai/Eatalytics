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
        VStack(spacing: 0) {
            Text("Dashboard")
                .fontWeight(.bold)
                .foregroundColor(Color("Dark"))
                .multilineTextAlignment(.leading)
                .font(.custom("Urbanist", fixedSize: 40))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .lineLimit(5)
                .minimumScaleFactor(0.5)
            Text("\(authModel.user?.email ?? "")")
        }
    }
    
    struct Dashboard_Previews: PreviewProvider {
        static var previews: some View {
            Dashboard()
                .environmentObject(AuthViewModel())
        }
    }
}
