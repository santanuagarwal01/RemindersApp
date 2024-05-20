//
//  RemindersAppApp.swift
//  RemindersApp
//
//  Created by Santanu Agarwal on 15/05/24.
//

import SwiftUI

@main
struct RemindersApp: App {

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
