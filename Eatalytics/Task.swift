//
//  Task.swift
//  Eatalytics
//
//  
//

import SwiftUI

// Task Model
struct Task: Identifiable{
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
}
