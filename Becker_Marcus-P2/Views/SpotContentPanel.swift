//
//  SpotContentPanel.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 5/1/24.
//

import SwiftUI

struct SpotContentPanel: View {
    
    var mapViewModel: MapViewModel
    
    var body: some View {
        panelContent()
    }
    
    
    @ViewBuilder
    private func panelContent() -> some View {
        switch mapViewModel.selectedSpot?.spotType {
        //case "leg": legContent()
        case "place": spotContent()
        case "home": spotContent()
        case nil: EmptyView()
        //default: EmptyView()
        default: spotContent()
        }
        
    }
    
    @ViewBuilder
    private func spotContent() -> some View {
        if let localSpot = mapViewModel.selectedSpot {
            @Bindable var bindSpot = mapViewModel.selectedSpot!
            
            VStack {
                
                TextField("Name", text: $bindSpot.name)
                ///Conditional place vs home vs leg
                
                Toggle("Home Base", systemImage: localSpot.iconName, isOn: $bindSpot.isHome)
                    .onChange(of: localSpot.isHome) { bindSpot.changeSpotType()}
                    .toggleStyle(ButtonToggleStyle()).tint(.green)
                    
                
                
                     
                //TextField("spotType", text: $bindSpot.spotType)
                Text("spotType: \(localSpot.spotType)")
                
                Text("\(localSpot.latitude)")
                Text("\(localSpot.longitude)")
                
                TextField("TA ID", text: $bindSpot.TA_ID)
                
                //Text("\(localSpot.TAInfo)")
                
                
                
                //TextField("", text: $bindSpot.)
            }
            
            if let localTAInfo = localSpot.TAInfo {
                VStack {
                    Text("\(localTAInfo.locationID ?? "")")
                    Text("\(localTAInfo.name ?? "")")
                    Text("\(localTAInfo.photoCount ?? "")")
                    
                }
                
                
            }
        }
    }
    
    
    @ViewBuilder
    private func legContent() -> some View {
        if let localSpot = mapViewModel.selectedSpot {
            @Bindable var bindSpot = mapViewModel.selectedSpot!
            
            VStack {
                //TODO: Create leg overview
                Text("Leg Overview")
            }
        }
    }
    
    
    
    
}


