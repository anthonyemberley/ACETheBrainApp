//
//  User.swift
//  Impact
//
//  Created by Anthony Emberley on 12/26/15.
//  Copyright © 2015 Impact. All rights reserved.
//



import UIKit
import SwiftyJSON

class UserAPI: NSObject {
    var id: Int!
    var username : String!
    var email : String!
    var created_at : NSDate?
    var updated_at : NSDate?
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        
        id = json["id"].intValue
        username = json["username"].stringValue
        email = json["email"].stringValue
        
        //dates
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let created_at_string = json["created_at"].stringValue
        let updated_at_string = json["updated_at"].stringValue
        
        
        created_at = dateformatter.date(from: created_at_string) as NSDate?
        updated_at = dateformatter.date(from: updated_at_string) as NSDate?
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if id != nil {
            dictionary["id"] = id
        }
        if username != nil {
            dictionary["username"] = username
        }
        if email != nil{
            dictionary["email"] = email
        }
                if created_at != nil{
            dictionary["created_at"] = created_at
        }
        if updated_at != nil{
            dictionary["updated_at"] = updated_at
        }
        
        return dictionary
    }
    
    
}
