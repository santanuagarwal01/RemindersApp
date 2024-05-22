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

    @State private var isPresented: Bool = false
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    MyListsView(myLists: myListResults)
                    Button(action: {
                        isPresented = true
                    }, label: {
                        Text("Add List")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    })
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
            .onChange(of: searchText, { oldValue, newValue in
                isSearching = !newValue.isEmpty ? true : false
                searchResults.nsPredicate = ReminderService.getRemindersBySearchTerm(newValue).predicate
            })
            .overlay(alignment: .center, content: {
                ReminderListView(reminders: searchResults)
                    .opacity(isSearching ? 1.0 : 0.0)
            })
            .padding()
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: Text("Search here"))
    }
}

#Preview {
    HomeView()
}
