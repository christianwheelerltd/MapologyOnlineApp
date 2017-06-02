//
//  APIInstance.swift
//  MapologyApp
//
//  Created by 34in on 15/03/17.
//  Copyright © 2017 Harsh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class APIInstance: NSObject {

    class func postDatatoServer(_ strURL: String,parameter:NSDictionary, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        //print("data \(parameter)")
        
        let finalUrl = baseUrl + strURL
        
        
        Alamofire.request(finalUrl, method: .post, parameters: parameter as? Parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
          
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
        
        
    }
    
    
    
    
    class func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        //print(strURL)
        
        Alamofire.request(strURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON { (responseObject) -> Void in
            
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
        
    }
    
    
    func registerUser(_ strURL: String,fname:String,lname:String,password:String,title:String,lat:String,long:String,employee:String,industry:String,email:String,mobile:String,profilePic:String,deviceType:String,deviceToken:String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        
        let params = ["data": ["firstName":fname,"lastName":lname,"password":password,"employee":employee,"industry":industry,"email":email,"mobile":mobile,"lati":lat,"longi":long,"profilePic":profilePic,"deviceType":deviceType,"deviceToken":deviceToken]]
        
        
        print(params)
        
        
        Alamofire.request(strURL, method: .post, parameters: params, encoding:
            
            JSONEncoding.default, headers:["Content-Type": "application/json"]).responseJSON { (responseObject) -> Void in
                
                print(responseObject)
                
                if responseObject.result.isSuccess {
                    let resJson = JSON(responseObject.result.value!)
                    success(resJson)
                }
                if responseObject.result.isFailure {
                    let error : Error = responseObject.result.error!
                    failure(error)
                }
        }
        
    }

    
    
}
