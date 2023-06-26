//
//  Dashboard.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/15/23.
//

import SwiftUI

struct Dashboard: View {
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
    @State private var isSheetPresented = false
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            // MARK: Lazy Stack With Pinned Header
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                
                Section(header: HeaderView()) {
                    
                    // MARK: Current Week View
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 10){
                            
                            ForEach(taskModel.currentWeek,id: \.self){day in
                                
                                VStack(spacing: 10){
                                    
                                    Text(taskModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    
                                    // EEE will return day as MON,TUE,....etc
                                    Text(taskModel.extractDate(date: day, format: "EEE"))
                                        .font(.system(size: 14))
                                    
                                    Circle()
                                        .fill(taskModel.isToday(date: day) ? Color.white : Color.clear)
                                        .frame(width: 8, height: 8)
                                }
                                // MARK: Foreground Style
                                .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                                .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                // MARK: Capsule Shape
                                .frame(width: 45, height: 90)
                                .background(
                                    
                                    ZStack{
                                        // MARK: Matched Geometry Effect
                                        if taskModel.isToday(date: day){
                                            Capsule()
                                                .fill(Color.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    // Updating Current Day
                                    withAnimation{
                                        taskModel.currentDay = day
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    TasksView()
                    
                }
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    // MARK: Tasks View
    func TasksView()->some View{
        
        LazyVStack(spacing: 20){
            
            if let tasks = taskModel.filteredTasks{
                
                if tasks.isEmpty{
                    
                    Text("No food logged")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .offset(y: 100)
                }
                else{
                    
                    ForEach(tasks){task in
                        TaskCardView(task: task)
                    }
                }
            }
            else{
                // MARK: Progress View
                ProgressView()
                    .offset(y: 100)
            }
        }
        .padding()
        .padding(.top)
        // MARK: Updating Tasks
        .onChange(of: taskModel.currentDay) { newValue in
            taskModel.filterTodayTasks()
        }
    }
    
    // MARK: Task Card View
    func TaskCardView(task: Task) -> some View {
        HStack(alignment: .top, spacing: 30) {
            VStack(spacing: 10) {
                Circle()
                    .fill(Color.clear)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(Color.black, lineWidth: 1)
                            .padding(-3)
                    )
                    .scaleEffect(0.8)
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 3)
            }
            
            VStack(alignment: .leading) { // Adjusted alignment
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(task.taskTitle)
                            .font(.title2.bold())
                        
                        Text(task.taskDescription)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Removed hLeading()
                    
                    Text(task.taskDate.formatted(date: .omitted, time: .shortened))
                }
            }
            .foregroundColor(Color("Dark"))
            //.padding()
            //.padding(.bottom, 10) // Adjusted padding
        }
    }
    
    // MARK: Header
    func HeaderView() -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading) // Removed hLeading()
                Text("Today")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading) // Removed hLeading()
            }
            Spacer()
            
            Button(action: {
                isSheetPresented = true
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
                    .foregroundColor(Color("Dark"))
            }
            .sheet(isPresented: $isSheetPresented) {
                SheetView()
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}


