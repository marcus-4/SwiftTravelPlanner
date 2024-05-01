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
        switch mapViewModel.selectedSpot {
        case nil: EmptyView()
        default: spotContent()
        }
        
    }
    
    @ViewBuilder
    private func spotContent() -> some View {
        
        
        if let localSpot = mapViewModel.selectedSpot {
            @Bindable var bindSpot = mapViewModel.selectedSpot!
            
            VStack {
                
                TextField("Name", text: $bindSpot.name)
                TextField("spotType", text: $bindSpot.spotType)
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
    
    
}


