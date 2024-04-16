//
//  PrototypeView.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 3/24/24.
//

import SwiftUI

struct PrototypeView: View {
    
    var body: some View {
        HSplitView {
            VStack{
                Text("Calendar/Timebar").padding()
                Text("Leg/Activity List").padding()
            }.frame(minWidth: 200, minHeight: 400).padding()
            Text("Main Map").padding().frame(minWidth: 600, minHeight: 800)
            //MapView()
            VStack{
                Text("Photo Preview").padding()
                Text("Tripadvisor").padding()
                
            }.frame(minWidth: 200, minHeight: 400).padding()
        }.frame(minWidth: 400, minHeight: 400).padding()
    }
}
