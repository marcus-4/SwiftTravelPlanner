//
//  DataModel.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/14/24.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class DataModel {
    
    private var container: ModelContainer
    
    var modelContext: ModelContext
    
    var allSpots: [Spot] = []
    
    var sortSpotsKeyPaths: [KeyPathComparator<Spot>] = [.init(\.name)]
    
    
    
    init() {
        
        let sharedModelContainer: ModelContainer = {
            let schema = Schema([
                Spot.self
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
        
        fetchData()
        
        
        
    }
    
    
    // MARK: - Fetching Data,currently causes my swiftcompile failure
    func fetchData() {
        do {
            let sortOrder = [SortDescriptor<Spot>(\.name)]
            let predicate = #Predicate<Spot>{ $0.isParent == true }
            //let predicate = #Predicate<Spot>{true}
            
            let descriptor = FetchDescriptor(predicate: predicate, sortBy: sortOrder)
            
            allSpots = try modelContext.fetch(descriptor)
        } catch {
            print("ERROR: Fetch Failed")
        }
    }
    
    
    
}
