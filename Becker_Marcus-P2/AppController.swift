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
    
    init() {
        dataModel = DataModel()
        
        
        
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
