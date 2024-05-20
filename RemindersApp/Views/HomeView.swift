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
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Test an item")
                Spacer()
                Button(action: {
                    isPresented = true
                }, label: {
                    Text("Add List")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                .padding()
            }
            .sheet(isPresented: $isPresented, content: {
                NavigationView(content: {
                    AddNewListView { name, color in
                        do {
                            try ReminderService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }
                    }
                })
            })
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
