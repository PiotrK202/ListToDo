//
//  ToDoTaskSelectionView.swift
//  ListToDo
//
//  Created by piotr koscielny on 10/6/25.
//

import SwiftUI

struct ToDoTaskTypeSelectionView: View {
    @State private var showTaskSheetWithNotification = false
    @State private var showTaskSheet = false
    @Bindable var viewModel: ListToDoViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Task Management")
                    .font(.largeTitle.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                VStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .frame(height: 120)
                        .overlay(
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Tasks with Notification")
                                    .font(.headline)
                                Text("Set reminders for important tasks that need timely completion.")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                        )    .onTapGesture {
                            showTaskSheetWithNotification.toggle()
                        }
                        .padding(.horizontal)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .frame(height: 120)
                        .overlay(
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Simple Tasks")
                                    .font(.headline)
                                Text("Add basic tasks without notifications for things you just need to remember to do.")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                        )
                        .onTapGesture {
                            showTaskSheet.toggle()
                        }
                        .padding(.horizontal)
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    Button {
                        showTaskSheetWithNotification = true
                    } label: {
                        HStack {
                            Image(systemName: "bell.fill")
                            Text("Add Task with Notification")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    .sheet(isPresented: $showTaskSheetWithNotification) {
                        TaskWithNotificationSheetView(viewModel: viewModel)
                    }
                    
                    Button {
                        showTaskSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Add Simple Task")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    .sheet(isPresented: $showTaskSheet) {
                        TaskSheetView(viewModel: viewModel)
                    }
                }
                .padding(.top)
                .padding(.bottom, 35)
            }
            .background(Color(.systemBackground))
        }
    }
}


#Preview {
    ToDoTaskSelectionView()
}
