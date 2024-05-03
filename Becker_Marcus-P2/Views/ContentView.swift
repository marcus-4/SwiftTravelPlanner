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
    
    @AppStorage("visibility_inspector") private var visibility_inspector = true
    ///NEED to get clear on source of truth
    //@Query private var spots: [Spot]
    
    //@Binding var visableRegion: MKCoordinateRegion?
    //@State var coordinate: CLLocationCoordinate2D

    ///@State private var selectedSpot: Spot?
    @Bindable var API = TripAdvisor_Location(locationID: "123456")
    
    //@Binding var searchStr: String
    
    
    var body: some View {
        @Bindable var dataModel = appController.dataModel
        @Bindable var mapViewModel = appController.mapViewModel
        
        let mapView = MapView(mapViewModel: mapViewModel)
        
        NavigationSplitView {
            List(selection: $mapViewModel.selectedSpot) {
                OutlineGroup(dataModel.allSpots, id: \.self, children: \.subSpots) { spot in
                    //TODO: Remove drop-down arrows from children - isLeaf
                    //OutlineGroup(dataModel.allSpots, id: \.self, parent: \.parentSpot, Leaf: {spot in spot.spotType == "place"}, children: \.subSpots) { spot in
                label: do {
                    HStack{
                        
                        Image(systemName: spot.iconName)
                        Text("\(spot.name)")
                    }
                }
                    
                }
                
                
            }.navigationTitle("Sidebar")
            //TODO: Be able to move/rearrange Spots
            //TODO: Find how to deselect better
            //            .onTapGesture {
            //                mapViewModel.selectedSpot = nil
            //            }
            
            ///TODO: Refactor toolbar, put buttons in main toolbar, left of title
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button(action: {addItem()}) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button(action: {deleteItem()}) {
                        Label("Delete Item", systemImage: "minus")
                    }
                }
                //TODO: Remove this, make automatic
                ToolbarItem {
                    Button(action: {apiCall()}) {
                        Label("Make API Call", systemImage: "tray.and.arrow.down")
                    }
                }
                
                
            }
        
        } content: {
            
            SpotContentPanel(mapViewModel: mapViewModel)
        } detail: {
            mapView
                .searchable(text: $mapViewModel.searchStr, isPresented: $mapViewModel.searchPresented, prompt: "New Locations")
                .onSubmit(of: .search) {
                    mapViewModel.search(for: mapViewModel.searchStr)
                    //searchStr probably doesn't need to be passed, since the viewmodel already holds the searchStr
                    
                    
                }
        }
        
        .inspector(isPresented: $visibility_inspector) {
            List(mapViewModel.searchResults, id: \.self, selection: $mapViewModel.selectedResult) {res in
                VStack(alignment: .leading, spacing: 0) {
                    Text(res.name ?? "Blank")
                    ///Expand view To show details upon selection
                    ///Find what MKLocalSearch can return exactly
                    ///Make seperate inspector View
                }
            }
            .padding()
            .frame(maxHeight: .infinity)
            .toolbar {
                ToolbarItem(id: "inspector") {
                    Button {
                        visibility_inspector.toggle()
                    } label: {
                        Image(systemName: "sidebar.right")
                    }
                }
                ///TODO: useTASearch Toggle
                ToolbarItem{
                    Button {
                        //visibility_inspector.toggle()
                    } label: {
                        Image(systemName: "search")
                    }
                }
                
            }
        }
        .onAppear() {
#if DEBUG
            //try? appController.dataModel.modelContext.delete(model: Spot.self)
            //appController.dataModel.fetchData()
#endif
        }
    }
    
    
        

    private func addItem() {
        //near golden
        //39.793086, -105.213767
        
        //appController.dataModel.createSpot(spotTitle: "maintest", parent: (appController.mapViewModel.selectedSpot ?? nil), isHome: false, lat: 39.793086, lon: -105.213767)
        
        if appController.mapViewModel.selectedMapItem != nil {
            appController.dataModel.createSpotSearch(item: appController.mapViewModel.selectedMapItem!, parent: (appController.mapViewModel.selectedSpot ?? nil), searchString: appController.mapViewModel.searchStr)
        }
        
        appController.mapViewModel.searchResults = []
        
        appController.mapViewModel.updateDisplayedSpots()
//        if let localLeg = appController.mapViewModel.selectedSpot {
//            localLeg.changeRegion(newRegion: appController.mapViewModel.visibleRegion)
//            
//        }
        
        
    }
    
    private func deleteItem() {
        withAnimation {
            if appController.mapViewModel.selectedSpot != nil {
                appController.dataModel.deleteSpot(spot: appController.mapViewModel.selectedSpot!)
            }
            appController.mapViewModel.selectedSpot = nil
        }
        appController.mapViewModel.updateDisplayedSpots()
    }
    
    //TODO: Remove this, make automatic
    
    private func apiCall() {
        //API.getLocation()
        appController.mapViewModel.apiUpdate()
        
    }
    
    
}

