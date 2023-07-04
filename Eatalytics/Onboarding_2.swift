//
//  Onboarding_2.swift
//  Eatalytics
//
//  Created by Manas Jain on 6/14/23.
//

import SwiftUI

struct Onboarding_2: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Text("STAY ON TRACK AND STAY MOTIVATED WITH CHASE!")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("Dark"))
                        .multilineTextAlignment(.leading)
                        .font(.custom("Urbanist", fixedSize: 35))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 5)
                        .lineLimit(4)
                        .minimumScaleFactor(0.5)
                }
                
                HStack {
                    Spacer()
                    
                    Text("Meet Chase, your personalized diet coach! Our resident panda will provide you with personalized reminders, insightful feedback, and supportive messages, empowering you to achieve your goals! \n\nChase your goals with Chase! ")
                        .foregroundColor(Color("Dark"))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Urbanist", fixedSize: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 5)
                        .lineLimit(nil)
                        .minimumScaleFactor(0.5)
                }
                
              
                
                Image("Chase")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom)
                
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
        .navigationBarBackButtonHidden(true) //hide back button
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Onboarding_2()
        }
    }
}
