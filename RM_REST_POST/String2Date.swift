//
//  String2Date.swift
//  RM_REST_POST
//
//  Created by Tatsuya Moriguchi on 10/29/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import Foundation

class String2Date {
    
    func getDate(strDate: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd, yyyy HH:mm:ss a"
        let date = dateFormatter.date(from: strDate)
        
        return date
    }
    
}
