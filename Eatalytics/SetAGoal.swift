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
            GeometryReader { geometry in
                VStack(spacing: 50) {
                    //Spacer()
                    
                    Text("Set a Goal!")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("Dark"))
                        .multilineTextAlignment(.leading)
                        .font(.custom("Urbanist", fixedSize: 40))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 5)
                        .lineLimit(4)
                        .minimumScaleFactor(0.5)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 133, height: 153)
                            .background(
                                Image("Chase")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 133, height: 153)
                                    .clipped()
                            )
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 35)
                            .fill(Color("LightGreen"))
                            .frame(width: 250, height: 50)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2) // Add drop shadow
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                if let intValue = Int(value), intValue >= 50 {
                                    let newValue = intValue - 50
                                    value = "\(newValue)"
                                }
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 45, height: 45)
                                    Image(systemName: "minus")
                                        .font(.title2)
                                        .foregroundColor(Color("Dark"))
                                }
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
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 45, height: 45)
                                    Image(systemName: "plus")
                                        .font(.title2)
                                        .foregroundColor(Color("Dark"))
                                }
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                        
                        NavigationLink(destination: Dashboard()) {
                            Text("DONE")
                                .foregroundColor(Color("Light"))
                                .fontWeight(.semibold)
                                .font(.custom("Urbanist", fixedSize: 25))
                                .foregroundColor(.white)
                                .padding(.horizontal, 100)
                                .padding(.vertical, 15.0)
                                .background(Color("Dark"))
                                .clipShape(Capsule())
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .bottom)
                    .padding(.horizontal)
                }
                .padding()
                .navigationBarHidden(true)
                .background(Color("Light").ignoresSafeArea())
                .frame(height: geometry.size.height)
            }
        }
        .navigationBarBackButtonHidden(true) //hide back button
    }
}

struct SetAGoal_Previews: PreviewProvider {
    static var previews: some View {
        SetAGoal()
    }
}





