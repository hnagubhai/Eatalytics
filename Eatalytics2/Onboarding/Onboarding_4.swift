//
//  Onboarding_3.swift
//  Eatalytics
//
//  
//

import SwiftUI

struct Onboarding_4: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Spacer()
                    .frame(height: 50) // Add additional spacing above the VStack
                
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
                        .minimumScaleFactor(0.5)
                }
                
                HStack {
                    Spacer()
                    
                    Text("Explore a variety of flavorful recipes curated to align with your goals, bringing you closer to a healthier you.")
                        .foregroundColor(Color("Dark"))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Urbanist", fixedSize: 25))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 5)
                        .lineLimit(nil)
                        .minimumScaleFactor(0.5)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    
                    
                    NavigationLink(destination: SignUpView().navigationBarHidden(true))
                    {
                        Text("GET STARTED")
                            .foregroundColor(Color("Light"))
                            .fontWeight(.semibold)
                            .font(.custom("Urbanist", fixedSize: 25))
                            .foregroundColor(.white)
                            .padding(.horizontal, 70)
                            .padding(.vertical, 20.0)
                            .background(Color("Dark"))
                            .clipShape(Capsule())
                    }
                    
                    Spacer() // Add a spacer to push the button to the center
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom) // Align the HStack to the bottom
                .padding(.horizontal)
                
                
            }
            .padding()
            .navigationBarHidden(true)
            .background(Color("Light").ignoresSafeArea())
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Onboarding_3_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding_3()
    }
}
