//
//  Task.swift
//  Eatalytics
//
//  Created by Manas Jain on 6/22/23.
//

import SwiftUI

// Task Model
struct Task: Identifiable{
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
}
