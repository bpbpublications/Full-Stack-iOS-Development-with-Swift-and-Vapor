//
//  CoreDataSampleApp.swift
//  CoreDataSample
//
//  Created by hdutt on 18/12/22.
//

import SwiftUI

@main
struct CoreDataSampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
