//
//  GetApiCall.swift
//  RM_REST_POST
//
//  Created by Tatsuya Moriguchi on 10/29/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

extension SportsNewsViewController {
    
    func AgetApiCall() {
        
        var newsData = [NewsData]()


        guard let url = URL(string: "https://ancient-wood-1161.getsandbox.com/results") else { return }

        var request = URLRequest(url: url)
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
                        let headLine =  "\(i.winner) wins \(i.tournament) by \(String(describing: i.seconds))"
                        newsData.append(NewsData(publicationDate: i.publicationDate, headLine: headLine))
                    }
                    
                    let tennisResultArray = response.Tennis
                    for i in tennisResultArray {
                        let headLine =  "\(i.tournament): \(i.winner) wins against \(String(describing: i.looser)) in \(String(describing: i.numberOfSets)) sets"
                        newsData.append(NewsData(publicationDate: i.publicationDate, headLine: headLine))
                        
                    }
                    
                    let nbaResultArray = response.nbaResults
                    for i in nbaResultArray {
                        
                        let headLine = "\(String(describing: i.mvp)) leads \(i.winner) to game \(String(describing: i.gameNumber)) win in the \(i.tournament)"
                        newsData.append(NewsData(publicationDate: i.publicationDate, headLine: headLine))
                    }
                    
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.timeZone = TimeZone(abbreviation: "UTF")
                    dateFormatter.dateFormat = "MM dd, yyyy HH:mm:ss a"
                    
                    self.sortedData = newsData.sorted(by: { dateFormatter.date(from: $0.publicationDate)?.compare(dateFormatter.date(from: $1.publicationDate)!) == .orderedDescending })
                                      
//
//                    for i in self.sortedData {
//                        print("publicationDate: \(i.publicationDate)")
//                        print("headLine: \(i.headLine))")
//                        print("")
//                    }
//                     Reload tableView in main thread to reflect downloaded and sorted JSON data
                    DispatchQueue.main.async {
                        SportsNewsViewController().tableView.reloadData()
                    }

                    
                } catch {
                    print("Error: \(error)")
                }

            }

        })
        task.resume()
    }
}
