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
                    //TODO: Remove drop-down arrows from children
                label: do {
                        HStack{
                            
                            Image(systemName: spot.iconName)
                            Text("\(spot.name)")
                        }
                    }
                    
                }
                
            }
            //TODO: Find how to deselect
//            .onTapGesture {
//                mapViewModel.selectedSpot = nil
//            }
            
            
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
            } detail: {
                mapView
                    .searchable(text: $mapViewModel.searchStr, isPresented: $mapViewModel.searchPresented, prompt: "New Locations")
                    .onSubmit(of: .search) {
                        mapViewModel.search(for: mapViewModel.searchStr)
                    }
                
                
            }
            .inspector(isPresented: $visibility_inspector) {
                List(mapViewModel.searchResults, id: \.self) {res in
                    VStack(alignment: .leading, spacing: 0) {
                        Text(res.name ?? "Blank")
                        
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
        
        //appController.dataModel.createLegTest(legTitle: "mainleg", homeTitle: "hostel")
    }
    
    private func deleteItem() {
        withAnimation {
            if appController.mapViewModel.selectedSpot != nil {
                appController.dataModel.deleteSpot(spot: appController.mapViewModel.selectedSpot!)
            }
            appController.mapViewModel.selectedSpot = nil
        }
    }
    
    //TODO: Remove this, make automatic
    private func apiCall() {
        //API.getLocation()
    }
    
    
}

