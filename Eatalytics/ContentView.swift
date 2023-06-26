//
//  TabView.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/22/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabBarView()
        }
        .navigationBarHidden(true) // Hide the navigation bar
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


