//
//  PreferencesView.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 5/3/24.
//

import SwiftUI

struct PreferencesView: View {
    
    //@State var APIKey: String
    @AppStorage("APIKey", store: .standard) var APIKey: String = ""
    
    
//    init(var APIKey: String) {
//        _APIKey = UserDefaults.standard.string(forKey: "APIKey") ?? ""
//    }
    
    var body: some View {
        TextField("API Key", text: $APIKey)
        
        Button(action: {UserDefaults.standard.set(APIKey, forKey: "APIKey")}) {
            Label("Save", systemImage: "save")
        }
    }
}

