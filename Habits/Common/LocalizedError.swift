//
//  LocalizedError.swift
//  Habits
//
//  Created by Aryan Sharma on 22/11/24.
//

import Foundation

enum RealmError: LocalizedError {
    case unabelToAddObject(Error)
    case unableToWriteUpdates(Error)
}

enum NewHabitError: LocalizedError {
    case notifAccessNotGranted
    case emptyInputEnterHabit
    case unableToAddHabitToDB(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .notifAccessNotGranted:
            "Please grant notification access."
        case .emptyInputEnterHabit:
            "Enter a habit."
        case .unableToAddHabitToDB(let error):
            "Unable to create new habit: \(error.localizedDescription)"
        }
    }
}


