//
//  TaskColumnView.swift
//  ListToDo
//
//  Created by piotr koscielny on 10/6/25.
//

import SwiftUI
import UniformTypeIdentifiers
import SwiftData

struct TaskColumnView: View {
    let title: String
    let tasks: [TaskModel]
    let columnType: TaskType
    let viewModel: ListToDoViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline.bold())
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 12) {
                ForEach(tasks) { task in
                    TaskCardView(task: task, viewModel: viewModel)
                        .draggable(task.transferable) {
                            TaskCardView(task: task, viewModel: viewModel)
                                .opacity(0.5)
                        }
                }
                
                if tasks.isEmpty {
                    Text("No tasks")
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, minHeight: 150)
            .padding()
            .background(Color.gray.opacity(0.15))
            .cornerRadius(12)
            .dropDestination(for: TransferableTask.self) { items, _ in
                guard let item = items.first else { return false }
                let descriptor = FetchDescriptor<TaskModel>(
                    predicate: #Predicate { $0.id == item.id })
                if let task = try? viewModel.modelContext.fetch(descriptor).first {
                    try? viewModel.moveTask(task, to: columnType)
                    return true
                }
                return false
            }
        }
    }
}

