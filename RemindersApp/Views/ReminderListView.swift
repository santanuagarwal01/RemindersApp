//
//  ReminderListView.swift
//  RemindersApp
//
//  Created by Santanu Agarwal on 21/05/24.
//

import SwiftUI

struct ReminderListView: View {
    let reminders: FetchedResults<Reminder>
    
    private func reminderCheckedChanged(_ reminder: Reminder) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = !reminder.isCompleted
        do {
            _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error.localizedDescription)
        }
    }

    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { events in
                switch events {
                    case .onInfo:
                        print("INFO")
                    case .onCheckedChange(let reminder):
                        reminderCheckedChanged(reminder)
                    case .onSelect(let reminder):
                        print("SELECTED")
                }
            }
        }
    }
}
