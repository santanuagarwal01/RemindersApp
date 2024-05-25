//
//  ContentView.swift
//  RemindersApp
//
//  Created by Santanu Agarwal on 15/05/24.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: []) private var myListResults: FetchedResults<MyList>
    @FetchRequest(sortDescriptors: []) private var searchResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(.all)) private var allResults: FetchedResults<Reminder>
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(.scheduled)) private var scheduledResults: FetchedResults<Reminder>
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(.completed)) private var completedResults: FetchedResults<Reminder>
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(.today)) private var todayResults: FetchedResults<Reminder>
    
    @State private var isPresented: Bool = false
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    
    private var reminderStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatsValues = ReminderStatsValues()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                ScrollView {
                    HStack{
                        NavigationLink {
                            ReminderListView(reminders: todayResults)
                        } label: {
                            ReminderStatsView(icon: "calendar", title: "Today", count: reminderStatsValues.todaysCount, iconColor: .blue)
                        }

                        NavigationLink {
                            ReminderListView(reminders: allResults)
                        } label: {
                            ReminderStatsView(icon: "tray.circle.fill", title: "All", count: reminderStatsValues.allCount, iconColor: .red)
                        }
                    }
                    
                    HStack{
                        NavigationLink {
                            ReminderListView(reminders: scheduledResults)
                        } label: {
                            ReminderStatsView(icon: "clock", title: "Scheduled", count: reminderStatsValues.scheduledCount, iconColor: .secondary)
                        }
                        
                        NavigationLink {
                            ReminderListView(reminders: completedResults)
                        } label: {
                            ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: reminderStatsValues.completedCount, iconColor: .primary)
                        }
                    }
                    
                    Text("My Lists")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    MyListsView(myLists: myListResults)
                                        
                    Button {
                        isPresented = true
                    } label: {
                        Text("Add List")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    AddNewListView { name, color in
                        do {
                            try ReminderService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .onChange(of: searchText) { oldValue, newValue in
                isSearching = !newValue.isEmpty ? true : false
                searchResults.nsPredicate = ReminderService.getRemindersBySearchTerm(newValue).predicate
            }
            .overlay(alignment: .center, content: {
                ReminderListView(reminders: searchResults)
                    .opacity(isSearching ? 1.0 : 0.0)
            })
            .onAppear{
                reminderStatsValues = reminderStatsBuilder.build(myListResults: myListResults)
            }
            .padding()
            .navigationTitle("Reminders")
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: Text("Search here"))
        
    }
}

#Preview {
    HomeView()
}
