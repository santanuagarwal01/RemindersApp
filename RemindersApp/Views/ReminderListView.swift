//
//  ReminderListView.swift
//  RemindersApp
//
//  Created by Santanu Agarwal on 21/05/24.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach (reminders) { reminder in
                    ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { events in
                        switch events {
                            case .onInfo:
                                showReminderDetail = true
                            case .onCheckedChange(let reminder, let isCompleted):
                                reminderCheckedChanged(reminder, isCompleted)
                            case .onSelect(let reminder):
                                selectedReminder = reminder
                        }
                    }
                }
                .onDelete { indexSet in
                    deleteReminder(indexSet)
                }
            }
        }
        .sheet(isPresented: $showReminderDetail, content: {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        })
    }
    
    private func reminderCheckedChanged(_ reminder: Reminder, _ isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        do {
            _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    private func deleteReminder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                try ReminderService.deleteReminder(reminder)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
