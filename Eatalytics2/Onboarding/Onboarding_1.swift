//
//  Welcome.swift
//  Eatalytics
//
//  Created by Manas Jain on 6/15/23.
//


import SwiftUI

struct Onboarding_1: View {
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
                    .minimumScaleFactor(0.5)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                NavigationLink(destination: Onboarding_2()) {
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




