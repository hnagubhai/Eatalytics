//
//  Dashboard.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/15/23.
//

import SwiftUI
import Firebase

struct Dashboard: View {
    @Namespace var animation
    @State private var isSheetPresented = false
    @ObservedObject var taskModel: TaskViewModel = TaskViewModel()

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                    Section(header: HeaderView(isSheetPresented: $isSheetPresented)) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(taskModel.currentWeek, id: \.self) { day in
                                    VStack(spacing: 10) {
                                        Text(taskModel.extractDate(date: day, format: "EEE"))
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                        Text(taskModel.extractDate(date: day, format: "dd"))
                                            .font(.system(size: 14))
                                    }
                                    .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                                    .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                    .frame(width: 45, height: 80)
                                    .background(
                                        ZStack {
                                            if taskModel.isToday(date: day) {
                                                Capsule()
                                                    .fill(Color.black)
                                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                            }
                                        }
                                    )
                                    .contentShape(Capsule())
                                    .onTapGesture {
                                        withAnimation {
                                            taskModel.currentDay = day
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }

                        LazyVStack(spacing: 20) {
                            if let tasks = taskModel.filteredTasks {
                                if tasks.isEmpty {
                                    Text("No food logged")
                                        .font(.system(size: 16))
                                        .fontWeight(.light)
                                        .offset(y: 100)
                                        .foregroundColor(Color("Dark"))
                                } else {
                                    VStack {
                                        HStack{
                                            Text("LOG")
                                                .font(.headline)
                                                .foregroundColor(Color("Dark"))
                                            Spacer()
                                        }
                                        Divider()
                                            .background(Color.gray)
                                            .padding(.vertical, 5)

                                        ForEach(tasks) { task in
                                            TaskCardView(task: task)
                                        }
                                    }
                                }
                            } else {
                                ProgressView()
                                    .offset(y: 100)
                            }
                        }
                        .padding()
                        .padding(.top)
                        .onChange(of: taskModel.currentDay) { newValue in
                            taskModel.filterTodayTasks()
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
            .background(Color("Light").edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $isSheetPresented) {
                SheetView()
                    .environmentObject(taskModel)
            }
        }
        .onAppear {
            taskModel.startListeningForUserItems()
        }
        .onDisappear {
            taskModel.stopListeningForUserItems()
        }
    }

    struct HeaderView: View {
        @Binding var isSheetPresented: Bool

        var body: some View {
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(Date().formatted(date: .abbreviated, time: .omitted))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(getGreeting())
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("Dark"))
                }
                Spacer()
                Button(action: {
                    isSheetPresented = true
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(Color("Dark"))
                }
            }
            .padding(.horizontal)
            .padding(.top, getSafeArea().top+10)
            .background(Color("Light"))
        }
    }

    func TaskCardView(task: Task) -> some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 30) {
                VStack(spacing: 10) {
                    

                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("Dark"))
                        .frame(width: 3)
                }

                VStack(alignment: .leading) {
                    HStack(alignment: .top, spacing: 10) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(task.taskTitle)
                                .font(.title2.bold())

                            Text(task.taskDescription)
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        Text(task.taskDate.formatted(date: .omitted, time: .shortened))
                    }
                }
                .foregroundColor(Color("Dark"))
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 5)
            .contentShape(Rectangle())

            .contextMenu(menuItems: {
                Button(action: {
                   
                }) {
                    Label("Edit", systemImage: "square.and.pencil")
                }
                Button(action: {
                    
                }) {
                    Label("Remove", systemImage: "trash")
                }
            })
        }
    }


    struct SheetView: View {
        @Environment(\.dismiss) var dismiss
        @EnvironmentObject var taskModel: TaskViewModel
        @State private var taskTitle = ""
        @State private var taskDescription = ""

        var body: some View {
            VStack {
                Text("Add Item")
                    .font(.largeTitle)

                TextField("Food", text: $taskTitle)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .font(.body)
                    .foregroundColor(Color("Dark"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("LightGray"), lineWidth: 1)
                    )
                    .padding(.horizontal)

                TextField("Calories", text: $taskDescription)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .font(.body)
                    .foregroundColor(Color("Dark"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("LightGray"), lineWidth: 1)
                    )
                    .padding(.horizontal)

                Button(action: {
                    addTask()
                }) {
                    Text("Add")
                        .padding()
                        .background(Color("LightGreen"))
                        .foregroundColor(Color("Dark"))
                        .cornerRadius(10)
                }
                .padding()

                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }

        private func addTask() {
            let newTask = Task(taskTitle: taskTitle, taskDescription: taskDescription, taskDate: Date())
            taskModel.addTaskToFirestore(task: newTask)
            dismiss()
        }
    }

    struct Dashboard_Previews: PreviewProvider {
        static var previews: some View {
            Dashboard()
        }
    }
}

func getSafeArea() -> UIEdgeInsets {
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
        return .zero
    }

    guard let safeArea = screen.windows.first?.safeAreaInsets else {
        return .zero
    }

    return safeArea
}

func getGreeting() -> String {
    let hour = Calendar.current.component(.hour, from: Date())

    if (hour >= 0 && hour < 12) {
        return "Good Morning!"
    } else if (hour >= 12 && hour < 17) {
        return "Good Afternoon!"
    } else {
        return "Good Evening!"
    }
}




