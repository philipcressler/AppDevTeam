//
//  JourneyDatabaseModelManager.swift
//  fs2014
//
//  Created by Patrick McAvoy on 12/10/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit

class JourneyDatabaseManager: NSObject {
    
    func getCoordinates()->AnyObject{
        var aDBManager: DBManager = DBManager(databaseFilename: "journies.sqlite")
        
        let query: String = "SELECT longitude,latitude FROM california"
//        var dbResults: Array = aDBManager.test()
        var dbResults = aDBManager.loadDataFromDB(query)
        
        
        return dbResults
    }
}
