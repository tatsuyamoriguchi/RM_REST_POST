//
//  String2Date.swift
//  RM_REST_POST
//
//  Created by Tatsuya Moriguchi on 10/29/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import Foundation

class String2Date {

    // Convert String date data to Date then sort in descending order
    // returns an array of NewsData type. See NewsData struct in DataModel.swift
    func sortByDateString(data: [NewsData]) -> [NewsData] {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTF")
        dateFormatter.dateFormat = "MMMM dd, yyyy HH:mm:ss a"
        
        let sortedData = data.sorted(by: { dateFormatter.date(from: $0.publicationDate)?.compare(dateFormatter.date(from: $1.publicationDate)!) == .orderedDescending })
        
        
        return sortedData
    }
    
    
    // Get MMddyyyy data to feed pickerView row data, which are used to predicate sortedData
    // to display news headlines by date
    func getMMMMddyyyy(data: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm:ss a"
        guard let dateData = dateFormatter.date(from: data) else { return "Error: uable to convert data parameter to Date type." }
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTF")
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let output = dateFormatter.string(from: dateData)
        
        return output
    }
    
    
    func extractDate4Picker(data: [NewsData]) -> Array<String> {
          var output = [String]()
        for i in data {
            if output.contains(i.date4PickerView) == false {
                output.append(i.date4PickerView)
            }
        }
        
          return output
      }

}

/*
 func getMMddyyyy(data: String) -> String {
     
     let dateFormatter = DateFormatter()
  
     dateFormatter.dateFormat = "MM dd, yyyy HH:MM:SS a"
  
     guard let dateData = dateFormatter.date(from: data) else { return "Error: uable to convert data parameter to Date type." }
     
     dateFormatter.locale = Locale(identifier: "en_US_POSIX")
     dateFormatter.timeZone = TimeZone(abbreviation: "UTF")
     dateFormatter.dateFormat = "MMMM dd, yyyy"
     let output = dateFormatter.string(from: dateData)
     
     return output
 }
 */
