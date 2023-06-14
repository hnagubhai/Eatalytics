//
//  ContentView.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/14/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    // Action
                }) {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding(.all, 30.0)
                        .background(Color("Dark"))
                        .clipShape(Circle())
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.horizontal)
        }
        .padding()
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .fixedSize(horizontal: false, vertical: true) // Allow text to expand vertically
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



