//
//  ContentView.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 3/24/24.
//

import SwiftUI
import SwiftData
import MapKit

struct ContentView: View {
    //@Environment(\.modelContext) private var modelContext
    @Environment(AppController.self) private var appController: AppController
    
    
    //@Query private var spots: [Spot]
    
    //@Binding var visableRegion: MKCoordinateRegion?
    //@State var coordinate: CLLocationCoordinate2D

    @State private var selectedSpot: Spot?
    @Bindable var API = TripAdvisor_Location(locationID: "123456")
    
    
    var body: some View {
        @Bindable var dataModel = appController.dataModel
        
        var mapView = MapView(spot: $selectedSpot)
        
        NavigationSplitView {
            List(selection: $selectedSpot) {
                OutlineGroup(dataModel.allSpots, id: \.self, children: \.subSpots) { spot in
                    //TODO: Remove drop-down arrows from children
                    NavigationLink {
                        ///use detail view instead, since NavigationLink will redraw & flash every time
                        mapView
                        //MapView()
                        
                    } label: {
                        HStack{
                            //need to be unique images
                            Image(systemName: "mappin.and.ellipse")
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
                    Button(action: {addItem()}) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button(action: {deleteItem()}) {
                        Label("Delet Item", systemImage: "minus")
                    }
                }
                //TODO: Remove this, make automatic
                ToolbarItem {
                    Button(action: {apiCall()}) {
                        Label("Make API Call", systemImage: "tray.and.arrow.down")
                    }
                }
            }
            } detail: {
                mapView
                //MapView()
            }
            .onAppear() {
#if DEBUG
                //try? appController.dataModel.modelContext.delete(model: Spot.self)
                //appController.dataModel.fetchData()
#endif
            }
        }
    
        

    private func addItem() {
        
        appController.dataModel.createSpot(spotTitle: "maintest", parent: (selectedSpot ?? nil), isHome: false, TA_ID: "12345", lat: 42.3, lon: 13)
        //appController.dataModel.createLegTest(legTitle: "mainleg", homeTitle: "hostel")
    }
    
    private func deleteItem() {
        withAnimation {
            if selectedSpot != nil {
                appController.dataModel.deleteSpot(spot: selectedSpot!)
            }
            selectedSpot = nil
        }
    }
    
    //TODO: Remove this, make automatic
    private func apiCall() {
        //API.getLocation()
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

