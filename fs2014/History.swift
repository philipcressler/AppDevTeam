//
//  History.swift
//  fs2014
//
//  Created by Jerrod Carpenter on 12/12/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import Foundation

class History: NSObject, NSCoding {
    var stamp: String!
    var postcard: String!
    
    // MARK: NSCoding
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.stamp = decoder.decodeObjectForKey("stamp") as String?
        self.postcard = decoder.decodeObjectForKey("postcard") as String?
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.stamp, forKey: "stamp")
        coder.encodeObject(self.postcard, forKey: "postcard")
    }
}
