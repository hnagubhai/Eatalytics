//
//  TaskViewModel.swift
//  Eatalytics
//
//  Created by Manas Jain on 6/22/23.
//


import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth

class TaskViewModel: ObservableObject {
    // Sample Tasks
    @Published var storedTasks: [Task] = []  {
        didSet {
            filterTodayTasks()
        }
    }

    // MARK: Current Week Days
    @Published var currentWeek: [Date] = []

    // MARK: Current Day
    @Published var currentDay: Date = Date()

    // MARK: Filtering Today Tasks
    @Published var filteredTasks: [Task]?

    // Firestore reference
    private let db = Firestore.firestore()

    // MARK: Initializing
    init() {
        fetchCurrentWeek()
        filterTodayTasks()
        loadTasksFromFirestore()
    }

    // MARK: Filter Today Tasks
    func filterTodayTasks() {
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current

            let filtered = self.storedTasks.filter {
                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }
            .sorted { task1, task2 in
                return task2.taskDate < task1.taskDate
            }

            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }

    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current

        let week = calendar.dateInterval(of: .weekOfMonth, for: today)

        guard let firstWeekDay = week?.start else {
            return
        }

        (0..<7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }

    // MARK: Extracting Date
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    // MARK: Checking if current Date is Today
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }

    // MARK: Checking if the currentHour is task Hour
    func isCurrentHour(date: Date) -> Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        return hour == currentHour
    }

    // MARK: Load Tasks from Firestore
    func loadTasksFromFirestore() {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("User not authenticated.")
            return
        }
        
        db.collection("users").document(userUID).collection("items").getDocuments { [weak self] (snapshot, error) in
            guard let self = self else { return }

            if let error = error {
                print("Error loading tasks from Firestore: \(error.localizedDescription)")
                return
            }

            var tasks: [Task] = []

            for document in snapshot?.documents ?? [] {
                if let taskDict = document.data() as? [String: Any],
                   let task = Task.fromDictionary(taskDict) {
                    tasks.append(task)
                }
            }

            DispatchQueue.main.async {
                self.storedTasks = tasks
            }
        }
    }

}

extension Task {
    static func fromDictionary(_ dictionary: [String: Any]) -> Task? {
        guard let taskTitle = dictionary["taskTitle"] as? String,
              let taskDescription = dictionary["taskDescription"] as? String,
              let timestamp = dictionary["taskDate"] as? Timestamp else {
            return nil
        }
        
        let taskDate = timestamp.dateValue()
        
        return Task(taskTitle: taskTitle, taskDescription: taskDescription, taskDate: taskDate)
    }
}





