//
//  ListToDoViewModel.swift
//  ListToDo
//
//  Created by piotr koscielny on 10/6/25.
//

import Foundation
import SwiftData
import UserNotifications
import UIKit

@MainActor
@Observable final class ListToDoViewModel {
    private let notificationHelper = NotificationHelper()
    let modelContext: ModelContext
    var showAlertWhenSaveModelFails = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addTask(title: String, taskDescription: String, type: TaskType, date: Date? = nil) {
        let task = TaskModel(title: title, taskDescription: taskDescription, type: type, notificationDate: date)
        modelContext.insert(task)
        saveModel()
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func moveTask(_ task: TaskModel, to newType: TaskType) throws {
        if task.type == .important && newType != .important {
            cancelNotification(for: task)
        }
        task.type = newType
        saveModel()
    }
    
    func deleteTask(_ task: TaskModel) throws {
        if task.type == .important {
            cancelNotification(for: task)
        }
        modelContext.delete(task)
        saveModel()
    }
    
    private func scheduleNotification(for task: TaskModel, at date: Date) throws {
        Task {
            let granted = await notificationHelper.requestPermission()
            guard granted else { return }
            
            let content = UNMutableNotificationContent()
            content.title = task.title
            content.body = task.taskDescription
            content.sound = .default
            
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date), repeats: false )
            
            let request = UNNotificationRequest(identifier: task.id.uuidString, content: content, trigger: trigger)
            try await UNUserNotificationCenter.current().add(request)
        }
    }
    
    private func cancelNotification(for task: TaskModel) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [task.id.uuidString])
    }
    
    private func saveModel() {
        do {
            try modelContext.save()
        } catch {
            showAlertWhenSaveModelFails = true
        }
    }
}
