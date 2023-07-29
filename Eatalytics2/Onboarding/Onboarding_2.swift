//
//  ContentView.swift
//  Eatalytics
//
//  
//

import SwiftUI

struct Onboarding_2: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Text("SEAMLESS START TO YOUR WELLNESS JOURNEY")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("Dark"))
                        .multilineTextAlignment(.leading)
                        .font(.custom("Urbanist", fixedSize: 45))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 5)
                        .lineLimit(5)
                        .minimumScaleFactor(0.5) // Adjust the scale factor as needed
                }
                
                HStack {
                    Spacer()
                    
                    Text("Embark on your wellness journey with ease. With an intuitive app experience, say goodbye to complexity and hello to a smoother path towards your goals.")
                        .foregroundColor(Color("Dark"))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Urbanist", fixedSize: 25))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 5)
                        .lineLimit(nil)
                        .minimumScaleFactor(0.5) // Adjust the scale factor as needed
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    NavigationLink(destination: Onboarding_3()) {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding(.all, 30.0)
                            .background(Color("Dark"))
                            .clipShape(Circle())
                    }
                }
                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                .padding(.horizontal)
            }
            .padding()
            .navigationBarHidden(true)
            .background(Color("Light").ignoresSafeArea())
        }
        .navigationBarBackButtonHidden(true)
    }
}



