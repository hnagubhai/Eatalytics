//
//  TabBar.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/25/23.
//

import SwiftUI

struct TabBar: View {
    @State var current = "Dashboard"
    @State var selection: Int? = nil
    
    var body: some View {
        NavigationView {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                TabView(selection: $current){
                    Dashboard()
                        .tag("Dashboard")
                    
                    ExploreView()
                        .tag("Explore")
                    
                    SettingsView()
                        .tag("Settings")
                }
                
                HStack(spacing: 0) {
                    TabButton(title: "Dashboard", systemName: "house", selected: $current)
                        .onTapGesture {
                            current = "Dashboard"
                            selection = nil
                        }
                    
                    Spacer(minLength: 0)
                    
                    TabButton(title: "Explore", systemName: "magnifyingglass", selected: $current)
                        .onTapGesture {
                            current = "Explore"
                            selection = 1
                        }
                    
                    Spacer(minLength: 0)
                    
                    TabButton(title: "Settings", systemName: "gear", selected: $current)
                        .onTapGesture {
                            current = "Settings"
                            selection = 2
                        }
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(Color("Dark"))
                .clipShape(Capsule())
                .padding(.horizontal, 25)
            }
            .navigationBarHidden(true)
            .background(NavigationLink("", destination: EmptyView(), tag: 1, selection: $selection))
            .background(NavigationLink("", destination: EmptyView(), tag: 2, selection: $selection))
        }
    }
}

