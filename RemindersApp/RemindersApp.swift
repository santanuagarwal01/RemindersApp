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
                .onAppear(perform: {
                    if let directoryLocation = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
                        print("Documents Directory: \(directoryLocation)Application Support")
                    }
                })
        }
    }
}
