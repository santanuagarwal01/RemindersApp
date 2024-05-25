//
//  ReminderDetailView.swift
//  RemindersApp
//
//  Created by Santanu Agarwal on 21/05/24.
//

import SwiftUI

struct ReminderDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var reminder: Reminder
    @State private var editConfig: ReminderEditConfig = ReminderEditConfig()
        
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                    
                    Section {
                        Toggle(isOn: $editConfig.hasDate, label: {
                            Image(systemName: "calendar")
                                .foregroundStyle(.red)
                        })
                        
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime, label: {
                            Image(systemName: "clock")
                                .foregroundStyle(.red)
                        })
                        
                        if editConfig.hasTime {
                            DatePicker("Select Time", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                    }
                    .onChange(of: editConfig.hasDate, { oldValue, newValue in
                        if newValue {
                            editConfig.reminderDate = Date()
                        }
                    })
                    .onChange(of: editConfig.hasTime, { oldValue, newValue in
                        if newValue {
                            editConfig.reminderTime = Date()
                        }
                    })
                    
                    Section {
                        NavigationLink {
                            SelectListView(selectedList: $reminder.list)
                        } label: {
                            HStack {
                                Text("List")
                                Spacer()
                                Text(reminder.list?.name ?? "")
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .onAppear{
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if isFormValid {
                            do {
                                let updated = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
                                if updated {
                                    if reminder.reminderDate != nil || reminder.reminderTime != nil {
                                        let userData = UserData(title: reminder.title, body: reminder.notes, date: reminder.reminderDate, time: reminder.reminderTime)
                                        NotificationManager.scheduleNotification(userData: userData)
                                    }
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                            dismiss()
                        }
                    } label: {
                        Text("Done")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}
