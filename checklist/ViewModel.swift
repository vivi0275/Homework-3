//
//  ViewModel.swift
//  checklist
//
//  Created by Andy Huang on 7/30/23.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var description = ""
    @Published var inProgressTasks: [String] = []
    @Published var completedTasks: [String] = []
    
    func addTask() {
        guard !description.isEmpty else { return }
        inProgressTasks.append(description)
        description = ""
    }
    
    func completeTask(_ task: String) {
        if let index = inProgressTasks.firstIndex(of: task) {
            inProgressTasks.remove(at: index)
        }
        completedTasks.append(task)
    }
    
    func uncompleteTask(_ task: String) {
        if let index = completedTasks.firstIndex(of: task) {
            completedTasks.remove(at: index)
        }
        inProgressTasks.append(task)
    }
}
