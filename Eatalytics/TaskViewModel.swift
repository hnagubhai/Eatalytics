//
//  TaskViewModel.swift
//  Eatalytics
//
//  
//

import SwiftUI

class TaskViewModel: ObservableObject{
    
    // Sample Tasks
    @Published var storedTasks: [Task] = [
    
        Task(taskTitle: "Pizza", taskDescription: "500 Calories", taskDate: .init(timeIntervalSince1970: 1687731893)),
        Task(taskTitle: "Burger", taskDescription: "500 Calories", taskDate: .init(timeIntervalSince1970: 1687731893)),
        Task(taskTitle: "Carrots", taskDescription: "500 Calories", taskDate: .init(timeIntervalSince1970: 1687731893)),
        Task(taskTitle: "Chips", taskDescription: "500 Calories", taskDate: .init(timeIntervalSince1970: 1687731893)),
        Task(taskTitle: "Pasta", taskDescription: "500 Calories", taskDate: .init(timeIntervalSince1970: 1687731893)),
        Task(taskTitle: "Noodles", taskDescription: "500 Calories", taskDate: .init(timeIntervalSince1970: 1687731893)),
        
        Task(taskTitle: "Oranges", taskDescription: "500 Calories", taskDate: .init(timeIntervalSince1970: 1687731893)),
        Task(taskTitle: "Apples", taskDescription: "500 Calories", taskDate: .init(timeIntervalSince1970: 1687731893)),
    ]
    
    // MARK: Current Week Days
    @Published var currentWeek: [Date] = []
    
    // MARK: Current Day
    @Published var currentDay: Date = Date()
    
    // MARK: Filtering Today Tasks
    @Published var filteredTasks: [Task]?
    
    // MARK: Intializing
    init(){
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    // MARK: Filter Today Tasks
    func filterTodayTasks(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let calendar = Calendar.current
            
            let filtered = self.storedTasks.filter{
                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }
                .sorted { task1, task2 in
                    return task2.taskDate < task1.taskDate
                }
            
            DispatchQueue.main.async {
                withAnimation{
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek(){
        
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else{
            return
        }
        
        (0..<7).forEach { day in
            
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
        }
    }
    
    // MARK: Extracting Date
    func extractDate(date: Date,format: String)->String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    // MARK: Checking if current Date is Today
    func isToday(date: Date)->Bool{
        
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    // MARK: Checking if the currentHour is task Hour
    func isCurrentHour(date: Date)->Bool{
        
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        return hour == currentHour
    }
}
