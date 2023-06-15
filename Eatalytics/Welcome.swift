//
//  Welcome.swift
//  Eatalytics
//
//  Created by Manas Jain on 6/15/23.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Text("WELCOME TO EATALYTICS")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("Green"))
                        .multilineTextAlignment(.leading)
                        .font(.custom("Urbanist", fixedSize: 50))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 5)
                        .lineLimit(5)
                        .minimumScaleFactor(0.5) // Adjust the scale factor as needed
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    NavigationLink(destination: ContentView()) {
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
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Welcome()
        }
    }
    
}

