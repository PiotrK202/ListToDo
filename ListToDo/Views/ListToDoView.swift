//
//  ContentView.swift
//  ListToDo
//
//  Created by piotr koscielny on 10/6/25.
//

import SwiftUI
import UniformTypeIdentifiers
import SwiftData

struct ListToDoView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TaskModel.createdAt) private var tasks: [TaskModel]
    @State private var showNotificationAlert = false
    @State var viewModel: ListToDoViewModel
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    TaskColumnView(
                        title: "Important",
                        tasks: tasks.filter { $0.type == .important },
                        columnType: .important,
                        viewModel: viewModel
                    )
                    .frame(minHeight: 200)
                    
                    TaskColumnView(
                        title: "Regular",
                        tasks: tasks.filter { $0.type == .regular },
                        columnType: .regular,
                        viewModel: viewModel
                    )
                    .frame(minHeight: 200)
                    
                    TaskColumnView(
                        title: "Completed",
                        tasks: tasks.filter { $0.type == .completed },
                        columnType: .completed,
                        viewModel: viewModel
                    )
                    .frame(minHeight: 200)
                }
                .padding()
            }
            .onAppear {
                viewModel = ListToDoViewModel(modelContext: modelContext)
            }
            .navigationTitle("To Do List")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ToDoTaskTypeSelectionView(viewModel: viewModel)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
