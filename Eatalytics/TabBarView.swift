//
//  TabBarView.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/25/23.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = "Dashboard"

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                Dashboard()
                    .tag("Dashboard")
                
                ExploreView()
                    .tag("Explore")
                
                SettingsView()
                    .tag("Settings")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Spacer() // Add Spacer to push TabBar to the bottom
            
            TabBar(selectedTab: $selectedTab)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}


