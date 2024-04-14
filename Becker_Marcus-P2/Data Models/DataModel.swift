//
//  DataModel.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/14/24.
//

import Foundation

import Foundation
import SwiftUI
import SwiftData

@Observable
class DataModel {
    
    private var container: ModelContainer
    
    var modelContext: ModelContext
    
    var allLegs: [Leg] = []
    
    var sortLegsKeyPaths: [KeyPathComparator<Leg>] = [.init(\.name)]
    
    
    @Transient
    var selectedSpots: [Spot] = []
    
    
    init() {
        let sharedModelContainer: ModelContainer = {
            let schema = Schema([
                Leg.self, Spot.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        
        container = sharedModelContainer
        
        modelContext = ModelContext(sharedModelContainer)
    }
    
    
    // MARK: - Fetching Data
    func fetchData() {
        do {
            let sortOrder = [SortDescriptor<Leg>(\.name)]
            //let predicate = #Predicate<Spot>{ $0.isHome == false }
            let predicate = #Predicate<Leg>
            
            let descriptor = FetchDescriptor(predicate: predicate, sortBy: sortOrder)
            
            allLegs = try modelContext.fetch(descriptor)
        } catch {
            print("ERROR: Fetch Failed")
        }
    }
    
    
    
}
