//
//  Set a Goal.swift
//  Eatalytics
//
//  Created by Manas Jain on 6/17/23.
//

import SwiftUI
import Combine

struct SetAGoal: View {
    @State private var value: String = "0"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Text("Set a Goal!")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("Dark"))
                        .multilineTextAlignment(.leading)
                        .font(.custom("Urbanist", fixedSize: 35))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 5)
                        .lineLimit(4)
                        .minimumScaleFactor(0.5)
                }
                
                Image("Chase")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom)
                
                HStack(spacing: 20) {
                    Button(action: {
                        if let intValue = Int(value), intValue >= 50 {
                            let newValue = intValue - 50
                            value = "\(newValue)"
                        }
                    }) {
                        Image(systemName: "minus.circle")
                            .font(.title)
                            .foregroundColor(Color("Green"))
                    }
                    
                    TextField("Enter Value", text: $value)
                        .keyboardType(.numberPad)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .onReceive(Just(value)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                value = filtered
                            }
                        }
                        .frame(width: 100)
                    
                    Button(action: {
                        if let intValue = Int(value) {
                            let newValue = intValue + 50
                            value = "\(newValue)"
                        }
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title)
                            .foregroundColor(Color("Green"))
                    }
                }
                
                HStack {
                    Spacer()
                    NavigationLink(destination: Dashboard()) {
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
}

struct SetAGoal_Previews: PreviewProvider {
    static var previews: some View {
        SetAGoal()
    }
}
