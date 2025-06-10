//
//  ListToDoApp.swift
//  ListToDo
//
//  Created by piotr koscielny on 10/6/25.
//

import SwiftUI

@main
struct ListToDoApp: App {
    var body: some Scene {
        WindowGroup {
            ListToDoView()
        }
        .modelContainer(for: TaskModel.self)
    }
}
