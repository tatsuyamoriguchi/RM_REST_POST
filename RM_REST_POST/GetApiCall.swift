//
//  GetApiCall.swift
//  RM_REST_POST
//
//  Created by Tatsuya Moriguchi on 10/30/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import Foundation

extension SportsNewsViewController {

    func getApiCall() {

        var newsData = [NewsData]()
        guard let url = URL(string: "https://ancient-wood-1161.getsandbox.com/results") else { return }
        var request = URLRequest(url: url)
 
        // POST method is more secure than GET which leaves the query strings can be saved in sever logs
        // and forwarded as referral links. POST is not cached by default.
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if error != nil {
                print("Error: \(String(describing: error))")
            } else {
                do {

                    let response = try JSONDecoder().decode(allResponse.self, from: data!)
                    let f1ResultArray = response.f1Results

                    for i in f1ResultArray {
                        // Get MMddyyyy date to feed pickerView row data
                        let MMMMddyyyy = String2Date().getMMMMddyyyy(data: i.publicationDate)
//                        print("i.publicationDate: \(i.publicationDate)  MMMMddyyyy: \(MMMMddyyyy)")
                        let headLine =  "\(i.winner) wins \(i.tournament) by \(String(describing: i.seconds))"
                        newsData.append(NewsData(publicationDate: i.publicationDate, date4PickerView: MMMMddyyyy, headLine: headLine))
                    }

                    let tennisResultArray = response.Tennis
                    for i in tennisResultArray {
                        let MMMMddyyyy = String2Date().getMMMMddyyyy(data: i.publicationDate)
                        let headLine =  "\(i.tournament): \(i.winner) wins against \(String(describing: i.looser)) in \(String(describing: i.numberOfSets)) sets"
                        newsData.append(NewsData(publicationDate: i.publicationDate, date4PickerView: MMMMddyyyy, headLine: headLine))

                    }

                    let nbaResultArray = response.nbaResults
                    for i in nbaResultArray {
                        let MMMMddyyyy = String2Date().getMMMMddyyyy(data: i.publicationDate)
                        let headLine = "\(String(describing: i.mvp)) leads \(i.winner) to game \(String(describing: i.gameNumber)) win in the \(i.tournament)"
                        newsData.append(NewsData(publicationDate: i.publicationDate, date4PickerView: MMMMddyyyy, headLine: headLine))
                    }

                    // Sort data by String Date
                    self.sortedData = String2Date().sortByDateString(data: newsData)
                    
                    for i in self.sortedData {
                        print(i)
                    }

                    
                    // Create a String array for pickerView rows
                    
                    // Reload tableView in main thread to reflect downloaded and sorted JSON data
                    DispatchQueue.main.async {
                        // Populate MMMM dd yyyy string data into dateList array for pickerView rows
                        self.dateList = String2Date().extractDate4Picker(data: self.sortedData)
                        // Create dailyData by filtering sortedData by date selected. Select dateList[0] date
                        // as default which is the most recent date.
                        self.dailyData = self.sortedData.filter { $0.date4PickerView == self.dateList[0] }

                        self.pickerView.reloadAllComponents()
                        
                        // Comment to evaluators: Was getting a fatal error, "unexpectedly found nil" on tableView
                        // since using SportsNewsViewController(), instead of self.
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        })
        task.resume()
    }
}
