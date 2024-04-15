//
//  ContentView.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 3/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //@Environment(\.modelContext) private var modelContext
    @Environment(AppController.self) private var appController: AppController
    
    
    @Query private var spots: [Spot]
    
    //private var legs: [Leg] = [Leg(name: "Rome", home: Spot(name: "rome_hostel")), Leg(name: "Florence", home: Spot(name: "Florence_hostel"))]
    //@State private var legs: [Leg] = appController.dataModel.allLegs
    

    
    
    //@State private var selectedLeg: Leg?
    @State private var selectedSpot: Spot?
    
    
    var body: some View {
        @Bindable var dataModel = appController.dataModel
        
        NavigationSplitView {
            List(selection: $selectedSpot) {
                //ForEach(legs) { leg in
                
                    //(selection: $selectedSpot){
                    OutlineGroup(dataModel.allSpots, id: \.self, children: \.subSpots) { spot in
                        //ForEach(leg.spots, id: \.self) { spot in
                        NavigationLink {
                            ///map values
                        } label: {
                            HStack{
                                //need to be unique images
                                Image(systemName: "folder.fill")
                                Text("\(spot.name)")
                            }
                        }
                        
                    }
                    
                    
                
                
                //.onDelete(perform: deleteItems)
                //TODO: ensure we have delete functionality
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button(action: {addItem(parent: selectedSpot)}) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            MapView()
        }
        .onAppear() {
#if DEBUG
            try? appController.dataModel.modelContext.delete(model: Spot.self)
#endif
        }

    }

    private func addItem(parent: Spot?) {
        //appController.dataModel.createSpot(spotTitle: "maintest", parent: parent, isHome: false)
        //appController.dataModel.createLegTest(legTitle: "mainleg", homeTitle: "hostel")
    }
    
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

