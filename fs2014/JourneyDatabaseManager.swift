//
//  JourneyDatabaseManager.swift
//  fs2014
//
//  Created by Philip Cressler on 12/11/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit

class JourneyDatabaseManager: NSObject {
    
    func getCoordinates(name: String)->[AnyObject]?{
        var aDBManager: DBManager = DBManager(databaseFilename:"journies.sqlite")
        var query = "SELECT * FROM "
        
        switch name{
            case "Route 66":
                query += "route"
            case "California":
                query += "california"
            case "Road to Hana":
                query += "kahului"
            case "Las Vegas Strip":
                query += "vegas"
            default:
                query += "vegas"
            
        }
        
        
        
        var results = aDBManager.loadDataFromDB(query)
        
        return results
    }
   
}
