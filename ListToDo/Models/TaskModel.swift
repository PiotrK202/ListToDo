//
//  TaskModel.swift
//  ListToDo
//
//  Created by piotr koscielny on 10/6/25.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

@Model
final class TaskModel: Identifiable, Hashable {
    @Attribute(.unique) var id: UUID
    var title: String
    var taskDescription: String
    var type: TaskType
    var notificationDate: Date?
    var createdAt: Date
    
    var transferable: TransferableTask {
        TransferableTask(id: id, title: title,
                         description: taskDescription,
                         type: type,
                         notificationDate: notificationDate)
    }
    
    init(id: UUID = UUID(), title: String, taskDescription: String, type: TaskType, notificationDate: Date? = nil, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.taskDescription = taskDescription
        self.type = type
        self.notificationDate = notificationDate
        self.createdAt = createdAt
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct TransferableTask: Codable, Transferable {
    let id: UUID
    let title: String
    let description: String
    let type: TaskType
    let notificationDate: Date?
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .task)
    }
}

extension UTType {
    static let task = UTType(exportedAs: "com.ListToDo.task")
}

enum TaskType: String, Codable {
    case important
    case regular
    case completed
}
