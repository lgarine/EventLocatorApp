//
//  WebService.swift
//  EventLocatorApp
//
//  Created by Lakshmi Prasanna Garine on 10/16/18.
//  Copyright © 2018 Lakshmi Prasanna Garine. All rights reserved.
//

import UIKit

class WebService: NSObject {
    
    
class func sharedInstance() -> WebService {
    var sharedObject: WebService? = nil
    
    var oneToken: Int = 0
    
    if (oneToken == 0) {
        sharedObject = WebService()
    }
    oneToken = 1
    
    return sharedObject!
}
    
override init()
{
    
   super.init()
    
}
    
  



}
