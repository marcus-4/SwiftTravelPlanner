//
//  Becker_Marcus_P2App.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 3/24/24.
//

import SwiftUI
import SwiftData

@main
struct Becker_Marcus_P2App: App {
    @State var appController = AppController()
    

    var body: some Scene {
        WindowGroup {
            //PrototypeView()
            //MapView()
            ContentView()
        }
        .environment(appController)
    }
}
