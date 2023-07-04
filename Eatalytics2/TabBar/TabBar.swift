//
//  TabBar.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/25/23.
//

import SwiftUI

struct TabBar: View {
    @State var current = "Dashboard"
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $current){
                
                Dashboard()
                    .tag("Home")
                
                Explore()
                    .tag("Explore")
                
                SettingsView()
                    .tag("Settings")
            }
            
            HStack(spacing: 0){
                
                // TabButton...
                
                TabButton(title: "Dashboard", systemName: "house", selected: $current)
                
                Spacer(minLength: 0)
                
                TabButton(title: "Explore", systemName: "magnifyingglass", selected: $current)
                
                Spacer(minLength: 0)
                
                TabButton(title: "Settings", systemName: "gear", selected: $current)
            }
            .padding(.vertical,12)
            .padding(.horizontal)
            .background(Color("Dark"))
            .clipShape(Capsule())
            .padding(.horizontal,25)
        }
    }
}

