//
//  SheetView.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/23/23.
//
import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Sheet View")
                .font(.largeTitle)
            
            Button(action: {
                dismiss()
            }) {
                Text("Dismiss")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
