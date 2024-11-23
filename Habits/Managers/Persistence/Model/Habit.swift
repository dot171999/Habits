//
//  Habit.swift
//  Habits
//
//  Created by Aryan Sharma on 22/11/24.
//

import Foundation
import RealmSwift

class Habit: Object, Identifiable {
    @Persisted(primaryKey: true) var name: String
}
