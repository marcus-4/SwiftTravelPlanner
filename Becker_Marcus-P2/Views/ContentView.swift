//
//  ContentView.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 3/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    //@Query private var items: [Item]
    
    //@Query private var legs: [Leg]
    
    private var legs: [Leg] = [Leg(name: "Rome", home: Spot(name: "rome_hostel")), Leg(name: "Florence", home: Spot(name: "Florence_hostel"))]
    
    @State private var selectedLeg: Leg?
    @State private var selectedSpot: Spot?
    
    
    

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(legs) { leg in
                    NavigationLink {
                        Text("Leg visiting \(leg.name)")
                    } label: {
                        Text("Home \(leg.home!.name)")
                    }
                }
                //.onDelete(perform: deleteItems)
                //TODO: ensure we have this functionality
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            MapView()
        }
    }

    //MARK: This is duplicate with hildreth's model, this adding should probably happen at the data model level, similar to how he has it
    private func addItem() {}
    
    /*
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
     */
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
