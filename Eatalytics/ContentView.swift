//
//  ContentView.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/14/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing:50) {
            
            Text("SEAMLESS START TO YOUR WELLNESS JOURNEY")
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                .font(.custom(
                        "Urbanist",
                        fixedSize: 45))
                .padding(.leading, 4.0)
            
            Text("Embark on your wellness journey with ease. With an intuitive app experience, say goodbye to complexity and hello to a smoother path towards your goals.")
                .fontWeight(.regular)
                .multilineTextAlignment(.leading)
                .font(.custom(
                        "Urbanist",
                        fixedSize: 25))
                .padding(.leading, 4.0)
                
            Spacer()
                
             
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
