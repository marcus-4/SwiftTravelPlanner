//
//  AppController.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/14/24.
//

import Foundation


@Observable
class AppController {
    var dataModel: DataModel
    //var selectionManager: SelectionManager
    var mapViewModel: MapViewModel
    
    init() {
        dataModel = DataModel()
        mapViewModel = MapViewModel()
        
        //I don't belive i need or want multiple selection
        //selectionManager = SelectionManager()
        
        //selectionManager.delegate = self
    }
    
}
/*
extension AppController: SelectionManagerDelegate {
    func selectedNodesDidChange(_ node: Set<Node>) {
        let sort = SortDescriptor<Node>(\.name)
        dataModel.selectedNodes = Array(node).sorted(using: sort)
    }
    
    
}
 
*/
