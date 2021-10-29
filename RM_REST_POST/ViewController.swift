//
//  ViewController.swift
//  RM_REST_POST
//
//  Created by Tatsuya Moriguchi on 10/26/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // add init
    var mergedData = [Item]()
    var localData = [Date]()
    var newsData = [NewsData]()
    
    func getApiCall() {
        
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
//                        i.sportsName = "f1"
//                        print(i.sportsName)
//                        print(i.publicationDate)
//                        print(i.seconds)
//                        print(i.tournament)
//                        print(i.winner)
//                        print("")
                        let headLine =  "\(i.winner) wins \(i.tournament) by \(i.seconds)"
                        self.newsData.append(NewsData(publicationDate: i.publicationDate, headLine: headLine))
                    }

                    let tennisResultArray = response.Tennis
                    for i in tennisResultArray {
//                        i.sportsName = "Tennis"
//                        print(i.sportsName)
//                        print(i.looser)
//                        print(i.numberOfSets)
//                        print(i.publicationDate)
//                        print(i.tournament)
//                        print(i.winner)
//                        print("")
                        let headLine =  "\(i.tournament): \(i.winner) wins against \(String(describing: i.looser)) in \(String(describing: i.numberOfSets)) sets"
                        self.newsData.append(NewsData(publicationDate: i.publicationDate, headLine: headLine))

                    }

                    let nbaResultArray = response.nbaResults
                    for i in nbaResultArray {
//                        i.sportsName = "NBA"
//                        print(i.sportsName)
//                        print(i.gameNumber)
//                        print(i.looser)
//                        print(i.publicationDate)
//                        print(i.tournament)
//                        print(i.winner)
//                        print("")
                        
                        let headLine = "\(i.mvp) leads \(i.winner) to game \(i.gameNumber) win in the \(i.tournament)"
                        self.newsData.append(NewsData(publicationDate: i.publicationDate, headLine: headLine))
                    }

 
                    print("")
                    print("***** newsData ******")
                    for i in self.newsData {
                        print(i)
                        print("")
                    }
                    
                    self.mergedData = f1ResultArray + tennisResultArray + nbaResultArray
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.timeZone = TimeZone(abbreviation: "UTF")
                    dateFormatter.dateFormat = "MM dd, yyyy HH:mm:ss a"
//                    let sortedData = self.mergedData.sorted(by: { dateFormatter.date(from: $0.publicationDate)?.compare(dateFormatter.date(from: $1.publicationDate)!) == .orderedAscending })
                    let sortedData = self.newsData.sorted(by: { dateFormatter.date(from: $0.publicationDate)?.compare(dateFormatter.date(from: $1.publicationDate)!) == .orderedDescending })

                    
                    print("")
                    print("")
                    print("**************")
                    for i in sortedData {
                        print("publicationDate: \(i.publicationDate)")
                        print("headLine: \(i.headLine))")

                        print("")
                    }

                    
                } catch {
                    print("Error: \(error)")
                }

            }
        
        })
        task.resume()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        getApiCall()
        
    }

}


struct NewsData {
    let publicationDate: String
    let headLine: String
}

struct allResponse: Codable {
    let nbaResults: [nbaResults]
    let Tennis: [Tennis]
    let f1Results: [f1Results]
}



struct nbaResults: Codable {
    let gameNumber: Int?
    let looser: String?
    let mvp: String?
    let publicationDate: String
    let tournament: String
    let winner: String
    
//    let numberOfSets: Int?
//    let seconds: Double?
//    var sportsName: String?
}

struct Tennis: Codable {
    let looser: String?
    let numberOfSets: Int?
    let publicationDate: String
    let tournament: String
    let winner: String
    
//    let gameNumber: Int?
//    let mvp: String?
//    let seconds: Double?
//    var sportsName: String?
}

struct f1Results: Codable {
    let publicationDate: String
    let seconds: Double?
    let tournament: String
    let winner: String
    
//    let gameNumber: Int?
//    let looser: String?
//    let mvp: String?
//    let numberOfSets: Int?
//    var sportsName: String?
}




protocol Item  {
    var publicationDate: String  { get }
    var tournament: String  { get }
    var winner: String  { get }

//    var seconds: Double?  { get }
//    var gameNumber: Int? { get }
//    var looser: String? { get }
//    var mvp: String? { get }
//    var numberOfSets: Int? { get }
//    var sportsName: String? { get }
}
extension f1Results: Item {}
extension Tennis: Item {}
extension nbaResults: Item {}



/*
 F1
 - Lewis Hamilton wins Silverstone Grand Prix by 5.856 seconds
 "\(winner) wins \(tounament) by \(seconds)"

 Tennis
 - Roland Garros: Rafael Nadal wins against Schwartzman in 3 sets
 - Roland Garros: Novak Djokovic wins against Schwartzman in 5 sets
 "\(tournament): \(winner) wins against \(looser) in \(numberOfSets) sets"

 NBA
 - Lebron James leads Lakers to game 4 win in the NBA playoffs
 "\(mvp) leads \(winner) to game \(gameNumber) win in the \(tournament)"



 */



/*
 json: ["f1Results": <__NSArrayI 0x6000033212c0>(
 {
     publicationDate = "May 9, 2020 8:09:03 PM";
     seconds = "5.856";
     tournament = "Silverstone Grand Prix";
     winner = "Lewis Hamilton";
 },
 {
     publicationDate = "Apr 14, 2020 8:09:03 PM";
     seconds = "7.729";
     tournament = "VTB RUSSIAN GRAND PRIX";
     winner = "Valtteri Bottas";
 },
 {
     publicationDate = "Mar 15, 2020 8:09:03 PM";
     seconds = "5.856";
     tournament = "Spa BELGIAN GRAND PRIX";
     winner = "Lewis Hamilton";
 }
 )
 , "Tennis": <__NSArrayI 0x600003321410>(
 {
     looser = "Schwartzman ";
     numberOfSets = 3;
     publicationDate = "May 9, 2020 11:15:15 PM";
     tournament = "Roland Garros";
     winner = "Rafael Nadal";
 },
 {
     looser = "Stefanos Tsitsipas ";
     numberOfSets = 3;
     publicationDate = "May 9, 2020 2:00:40 PM";
     tournament = "Roland Garros";
     winner = "Novak Djokovic";
 },
 {
     looser = "Petra Kvitova";
     numberOfSets = 3;
     publicationDate = "May 8, 2020 4:33:17 PM";
     tournament = "Roland Garros";
     winner = "Sofia Kenin";
 }
 )
 , "nbaResults": <__NSArrayI 0x600002803400>(
 {
     gameNumber = 6;
     looser = Heat;
     mvp = "Lebron James";
     publicationDate = "May 9, 2020 9:15:15 AM";
     tournament = "NBA playoffs";
     winner = Lakers;
 },
 {
     gameNumber = 5;
     looser = Lakers;
     mvp = "Jimmy Butler";
     publicationDate = "May 7, 2020 3:15:00 PM";
     tournament = "NBA playoffs";
     winner = Heat;
 },
 {
     gameNumber = 4;
     looser = Heat;
     mvp = "Anthony Davis";
     publicationDate = "May 5, 2020 1:34:15 PM";
     tournament = "NBA playoffs";
     winner = Lakers;
 },
 {
     gameNumber = 3;
     looser = Lakers;
     mvp = "Jimmy Butler";
     publicationDate = "May 3, 2020 9:15:33 PM";
     tournament = "NBA playoffs";
     winner = Heat;
 },
 {
     gameNumber = 2;
     looser = Heat;
     mvp = "Anthony Davis";
     publicationDate = "May 2, 2020 6:07:03 AM";
     tournament = "NBA playoffs";
     winner = Lakers;
 }
 )
 ]
 */




class String2Date {
    
    func getDate(strDate: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd, yyyy HH:mm:ss a"
        let date = dateFormatter.date(from: strDate)
        
        return date
    }
    
}
