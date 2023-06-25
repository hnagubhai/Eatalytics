//
//  TabView.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0
    @State private var showingSheet = false

    var body: some View {
        TabView(selection: $selectedTab) {
            Dashboard()
                .tabItem {
                    Image(systemName: "house")
                    Text("Dashboard")
                }
                .tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(2)
        }
        .overlay(
            TabBar(selectedTab: $selectedTab),
            alignment: .bottom
        )
        .sheet(isPresented: $showingSheet) {
            SheetView()
        }
    }
}

struct TabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            Button(action: {
                selectedTab = 0
            }) {
                Image(systemName: "house")
                    .foregroundColor(selectedTab == 0 ? .blue : .gray)
            }
            
            Spacer()
            
            Button(action: {
                selectedTab = 1
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(selectedTab == 1 ? .blue : .gray)
            }
            
            Spacer()
            
            Button(action: {
                selectedTab = 2
            }) {
                Image(systemName: "gear")
                    .foregroundColor(selectedTab == 2 ? .blue : .gray)
            }
        }
        .padding()
        .background(Color.white)
        .shadow(radius: 2)
        .navigationBarBackButtonHidden(true)
    }
}



