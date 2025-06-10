//
//  ListToDoApp.swift
//  ListToDo
//
//  Created by piotr koscielny on 10/6/25.
//

import SwiftUI

@main
struct ListToDoApp: App {
    @Environment(\.modelContext) private var modelContext
    
    init() {
        UITextView.appearance().inputAssistantItem.leadingBarButtonGroups = []
        UITextView.appearance().inputAssistantItem.trailingBarButtonGroups = []
    }
    
    var body: some Scene {
        WindowGroup {
            ListToDoView(viewModel: ListToDoViewModel(modelContext: modelContext))
        }
        .modelContainer(for: TaskModel.self)
    }
}
