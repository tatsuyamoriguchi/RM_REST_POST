//
//  SpotsNewsViewController.swift
//  RM_REST_POST
//
//  Created by Tatsuya Moriguchi on 10/29/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class SportsNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var sortedData = [NewsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        title = "Sports News"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        getApiCall()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = sortedData[indexPath.row].headLine
        cell.detailTextLabel?.text = sortedData[indexPath.row].publicationDate
        
        return cell
    }
    
    
    
    
    


    func getApiCall() {
        
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
                    

                    // Reload tableView in main thread to reflect downloaded and sorted JSON data
                    DispatchQueue.main.async {
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
