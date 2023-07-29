//
//  TaskViewModel.swift
//  Eatalytics
//
//  
//


import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth

class TaskViewModel: ObservableObject {
    // Empty Task Array to be populated by Firestore
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
    
    private var userItemsListener: ListenerRegistration?

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
                    if let taskTitle = document["taskTitle"] as? String,
                       let taskDescription = document["taskDescription"] as? String,
                       let taskDate = (document["taskDate"] as? Timestamp)?.dateValue(),
                       let id = document.documentID as? String
                    {
                        let task = Task(id: id, taskTitle: taskTitle, taskDescription: taskDescription, taskDate: taskDate)
                        tasks.append(task)
                    }
                }

                DispatchQueue.main.async {
                    self.storedTasks = tasks
                }
            }
        }


    // MARK: Add Task to Firestore
    func addTaskToFirestore(task: Task) {
            guard let userUID = Auth.auth().currentUser?.uid else {
                print("User not authenticated.")
                return
            }
            
            let data: [String: Any] = [
                "taskTitle": task.taskTitle,
                "taskDescription": task.taskDescription,
                "taskDate": Timestamp(date: task.taskDate)
            ]
            
            let userRef = db.collection("users").document(userUID)
            let itemsCollectionRef = userRef.collection("items")
            
            itemsCollectionRef.addDocument(data: data) { error in
                if let error = error {
                    print("Error adding task to Firestore: \(error.localizedDescription)")
                } else {
                    print("Task added successfully to Firestore.")
                }
            }
        }
    
    func deleteTaskFromFirestore(task: Task) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("User not authenticated.")
            return
        }

        let userRef = db.collection("users").document(userUID)
        let itemsCollectionRef = userRef.collection("items")

        let taskDocumentRef = itemsCollectionRef.document(task.id)

        taskDocumentRef.delete { error in
            if let error = error {
                print("Error deleting task from Firestore: \(error.localizedDescription)")
            } else {
                print("Task deleted successfully from Firestore.")
            }
        }
    }


    
    func startListeningForUserItems() {
            guard let userUID = Auth.auth().currentUser?.uid else {
                print("User not authenticated.")
                return
            }

            let itemsCollectionRef = Firestore.firestore().collection("users").document(userUID).collection("items")

            userItemsListener = itemsCollectionRef.addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }

                if let error = error {
                    print("Error listening for user items: \(error.localizedDescription)")
                    return
                }

                var tasks: [Task] = []
                for document in snapshot?.documents ?? [] {
                    if let taskTitle = document["taskTitle"] as? String,
                       let taskDescription = document["taskDescription"] as? String,
                       let taskDate = (document["taskDate"] as? Timestamp)?.dateValue(),
                       let id = document.documentID as? String
                    {
                        let task = Task(id: id, taskTitle: taskTitle, taskDescription: taskDescription, taskDate: taskDate)
                        tasks.append(task)
                    }
                }

                DispatchQueue.main.async {
                    self.storedTasks = tasks
                }
            }
        }

       func stopListeningForUserItems() {
           userItemsListener?.remove()
       }
   }



extension Task {
    static func fromDocumentSnapshot(_ documentSnapshot: DocumentSnapshot) -> Task? {
        guard let taskTitle = documentSnapshot["taskTitle"] as? String,
              let taskDescription = documentSnapshot["taskDescription"] as? String,
              let taskDate = (documentSnapshot["taskDate"] as? Timestamp)?.dateValue(),
              let id = documentSnapshot.documentID as? String
        else {
            return nil
        }

        return Task(id: id, taskTitle: taskTitle, taskDescription: taskDescription, taskDate: taskDate)
    }
}





