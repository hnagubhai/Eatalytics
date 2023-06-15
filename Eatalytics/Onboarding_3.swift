//
//  Onboarding_3.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/15/23.
//

import SwiftUI

struct Onboarding_3: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Text("DISCOVER DELICIOUS PATHS TO YOUR GOALS")
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
                    
                    Text("Explore a variety of flavorful recipes curated to align with your goals,  bringing you closer to a healthier you.")
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
                    NavigationLink(destination: Onboarding_2()) {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding(.horizontal, 90.0) // Increase the horizontal padding to make the capsule longer
                            .padding(.vertical, 25.0) // Adjust the vertical padding as needed
                            .background(Color("Dark"))
                            .clipShape(Capsule())
                    }
                    .frame(width: 200, height: 50) // Adjust the width and height as needed

                }
                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                .padding(.horizontal)
            }
            .padding()
            .navigationBarHidden(true)
            .background(Color("Light").ignoresSafeArea())
        }
        .navigationBarBackButtonHidden(true) //hide back button
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Onboarding_3()
        }
    }
}
