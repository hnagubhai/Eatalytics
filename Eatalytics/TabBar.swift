//
//  TabBar.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/25/23.
//

import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: String
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { tab in
                TabButton(title: tab, selectedTab: $selectedTab)
                if tab != tabs.last {
                    Spacer(minLength: 0)
                }
            }
        }
        .padding(.horizontal, 30)
        .background(Color("LightGreen"))
    }
}

struct TabButton: View {
    var title: String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {
            selectedTab = title
        }) {
            VStack(spacing: 6) {
                ZStack {
                    CustomShape()
                        .fill(Color.clear)
                        .frame(width: 45, height: 6)
                    
                    if selectedTab == title {
                        CustomShape()
                            .fill(Color("tint"))
                            .frame(width: 45, height: 6)
                    }
                }
                .padding(.bottom, 10)
                
                Image(title)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(selectedTab == title ? Color("tint") : Color.black.opacity(0.2))
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundColor(Color.black.opacity(selectedTab == title ? 0.6 : 0.2))
            }
        }
    }
}

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        return Path(path.cgPath)
    }
}

var tabs = ["Dashboard", "Explore", "Settings"]
