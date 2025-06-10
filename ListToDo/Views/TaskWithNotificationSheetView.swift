//
//  TaskWithNotificationSheetView.swift
//  ListToDo
//
//  Created by piotr koscielny on 10/6/25.
//

import SwiftUI

struct TaskWithNotificationSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: ListToDoViewModel
    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Add Task With Notification")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 14)
                
                TextField("Task Title", text: $title)
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                    .focused($isInputActive)
                
                TextEditor(text: $description)
                    .frame(minHeight: 80)
                    .padding(4)
                    .background(Color.gray.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                    .focused($isInputActive)
                
                DatePicker("Notification Date", selection: $date)
                    .padding(.horizontal)
                    .datePickerStyle(.compact)
                    .padding()
                
                Spacer()
                
                Button("Add") {
                    viewModel.hideKeyboard()
                    isInputActive = false
                    viewModel.addTask(title: title, taskDescription: description, type: .important, date: date)
                    dismiss()
                }
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            }
            .padding(.bottom, 35)
            .scrollDismissesKeyboard(.interactively)
            .background(Color(.systemBackground).onTapGesture {
                viewModel.hideKeyboard()
                isInputActive = false
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .alert("save failed", isPresented: $viewModel.showAlertWhenSaveModelFails) {
                Button("exit") {
                    dismiss()
                }
            } message: {
                Text("Saving task went wrong!")
            }
        }
    }
}
