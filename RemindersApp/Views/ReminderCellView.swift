//
//  ReminderCellView.swift
//  RemindersApp
//
//  Created by Santanu Agarwal on 21/05/24.
//

import SwiftUI

enum ReminderCellEvents {
    case onInfo
    case onCheckedChange(Reminder, Bool)
    case onSelect(Reminder)
}

struct ReminderCellView: View {
    
    let reminder : Reminder
    let isSelected: Bool
    let onEvent: (ReminderCellEvents) -> Void
    
    let delay = Delay()

    @State private var checked: Bool = false
    
    var body: some View {
        
        HStack {
            Image(systemName: checked ? "circle.inset.filled": "circle")
                .opacity(0.4)
                .font(.title2)
                .onTapGesture {
                    checked.toggle()
                    delay.cancel() // cancel old task
                    delay.performWork { // call onCheckedChange inside delay
                        onEvent(.onCheckedChange(reminder, checked))
                    }
                }
            
            VStack(alignment: .leading) {
                Text(reminder.title ?? "")
                if let notes = reminder.notes, !notes.isEmpty {
                    Text(notes)
                        .opacity(0.4)
                        .font(.caption)
                }
                HStack {
                    if let date = reminder.reminderDate {
                        Text(formatDate(date))
                    }
                    if let time = reminder.reminderTime {
                        Text(time.formatted(date: .omitted, time: .shortened))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .opacity(0.4)
            }
            
            Spacer()
            
            Image(systemName: "info.circle.fill")
                .opacity(isSelected ? 1.0 : 0.0)
                .onTapGesture {
                    onEvent(.onInfo)
                }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onEvent(.onSelect(reminder))
        }
        .onAppear(perform: {
            checked = reminder.isCompleted
        })
    }
    
    private func formatDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
}
