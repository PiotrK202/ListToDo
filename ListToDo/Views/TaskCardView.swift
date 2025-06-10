//
//  TaskCardView.swift
//  ListToDo
//
//  Created by piotr koscielny on 10/6/25.
//

import SwiftUI

struct TaskCardView: View {
    let task: TaskModel
    let viewModel: ListToDoViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(task.title)
                .font(.headline)
                .foregroundStyle(.primary)
            
            if !task.taskDescription.isEmpty {
                Text(task.taskDescription)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
            }
            
            if let date = task.notificationDate, task.type == .important {
                Text(date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            
            Button(role: .destructive) {
                try? viewModel.deleteTask(task)
            } label: {
                Text("Delete")
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
            }
            .buttonStyle(.bordered)
            .tint(.red)
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(task.type == .important ? Color.red.opacity(0.2) : Color.gray.opacity(0.2))
        .cornerRadius(4)
        .shadow(radius: 1)
    }
}
