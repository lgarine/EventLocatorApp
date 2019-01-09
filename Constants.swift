//
//  Constants.swift
//  EventLocatorApp
//
//  Created by Lakshmi Prasanna Garine on 1/8/19.
//  Copyright © 2019 Lakshmi Prasanna Garine. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    
    struct GlobalConstants {
        // Check Device IPHONE
        
        static let  kIphone_4s : Bool =  (UIScreen.main.bounds.size.height == 480)
        
        static let kIphone_5 : Bool =  (UIScreen.main.bounds.size.height == 568)
        
        static let kIphone_6 : Bool =  (UIScreen.main.bounds.size.height == 667)
        
        static let kIphone_6_Plus : Bool =  (UIScreen.main.bounds.size.height == 736)
        
        static let kIphone_X : Bool = (UIScreen.main.bounds.size.height == 812)
        
        static let urlString  =  "google.com"

        
    }
    

}
