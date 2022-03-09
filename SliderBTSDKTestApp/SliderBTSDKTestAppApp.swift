//
//  SliderBTSDKTestAppApp.swift
//  SliderBTSDKTestApp
//
//  Created by Frankie on 09/03/2022.
//

import SwiftUI

@main
struct SliderBTSDKTestAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
