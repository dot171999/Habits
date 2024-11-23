//
//  NewHabitViewModel.swift
//  Habits
//
//  Created by Aryan Sharma on 22/11/24.
//

import Foundation
import UserNotifications

@Observable class NewHabitViewModel {
    private let realmManager: RealmManagerProtocol
    var inputHabitName: String = ""
    var inputDate: Date = Date.now
    var inputNotifToggle: Bool = false
    
    private(set) var errorMessage: String = ""
    var showErrorAlert: Bool = false
    
    var habits: [String] = ["Read a Book", "Exercise", "Wake up early", "Walk Dog"]
    
    init(realmManager: RealmManagerProtocol = RealmManager()) {
        self.realmManager = realmManager
    }
    
    func createNewHabit() async -> Bool {
        guard !inputHabitName.isEmpty else {
            errorMessage = NewHabitError.emptyInputEnterHabit.localizedDescription
            showErrorAlert = true
            return false
        }
        
        do {
            try addHabitToDB()
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert = true
            return false
        }
        
        if inputNotifToggle {
            guard await requestNotifAccess() else {
                errorMessage = NewHabitError.notifAccessNotGranted.localizedDescription
                showErrorAlert = true
                return false
            }
            setNotification()
        }
        
        return true
    }
}

extension NewHabitViewModel {
    private func addHabitToDB() throws {
        let newHabit  = Habit()
        newHabit.name = inputHabitName
        do {
            try realmManager.add(object: newHabit)
        } catch {
            throw NewHabitError.unableToAddHabitToDB(error: error)
        }
    }
    
    private func requestNotifAccess() async -> Bool {
        let center = UNUserNotificationCenter.current()
        do {
            if try await center.requestAuthorization(options: [.alert, .badge]) == true {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    private func setNotification() {
        let content = UNMutableNotificationContent()
        content.title = "It is time."
        content.subtitle = "Habit: " + inputHabitName
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: inputDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func resetErrorMessage() {
        errorMessage = ""
    }
}
