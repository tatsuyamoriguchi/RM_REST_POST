//
//  String2Date.swift
//  RM_REST_POST
//
//  Created by Tatsuya Moriguchi on 10/29/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import Foundation

class String2Date {
    
    func sortByDateString(data: [NewsData]) -> [NewsData] {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTF")
        dateFormatter.dateFormat = "MM dd, yyyy HH:mm:ss a"
        
        let sortedData = data.sorted(by: { dateFormatter.date(from: $0.publicationDate)?.compare(dateFormatter.date(from: $1.publicationDate)!) == .orderedDescending })
        
        return sortedData
    }
    

}
