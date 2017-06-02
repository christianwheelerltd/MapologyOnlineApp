//
//  ArticleModel.swift
//  MapologyApp
//
//  Created by 34in on 04/04/17.
//  Copyright © 2017 Harsh. All rights reserved.
//

//category = "<null>";
//coverImage = "heartbeat-D5C0gj66ZJ-.png";
//distance = "5.74";
//followed = 0;
//id = 22;
//lati = "30.7114235";
//longi = "76.6908392";
//retailerId = 10;
//title = Pizza3;


import UIKit

class ArticleModel: NSObject {
    
    var category = NSString()
    var coverImage =  NSString()
    var distance = Float()
    var followed = Int()
    var ids_arr = Int()
    var lati = Double()
    var longi = Double()
    var retailerId = Int()
    var title = NSString()
    
    
    init(_ data: NSDictionary)
    {
        super.init()
        
        category = data.string(for: "category")
        
        coverImage = data.string(for: "coverImage")
        
        distance = data.float(for: "distance")
        
        followed = data.int(for: "followed")
        
        ids_arr = data.int(for: "id")
        
        lati = data.double(for: "lati")
        
        longi = data.double(for: "longi")
        
        retailerId = data.int(for: "retailerId")
        
        title = data.string(for: "title")
    
    }
}


extension NSDictionary
{
    func string(for key : String) -> NSString
    {
        if let value = self.value(forKey: key) as? NSString
        {
            return value
        }
        
        return ""
    }
    
    
    func double(for key : String) -> Double
    {
        if let value = self.value(forKey: key) as? Double
        {
            return value
        }
        
        return 0.0
    }
    
    
    func int(for key : String) -> Int
    {
        if let value = self.value(forKey: key) as? Int
        {
            return value
        }
        
        return 0
    }
    
    func float(for key : String) -> Float
    {
        if let value = self.value(forKey: key) as? Float
        {
            return value
        }
        
        return 0.0
    }
    
}

