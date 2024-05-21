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
                        
                        if editConfig.hasDate {
                            DatePicker("Select Time", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                    }
                    
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
