//
//  ViewController.swift
//  RM_REST_POST
//
//  Created by Tatsuya Moriguchi on 10/26/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mergedData = [Item]()
    var localData = [Date]()
    
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
//                    let json = try JSONSerialization.jsonObject(with: data!)
//                    print("json: \(json)")
                    
                    let response = try JSONDecoder().decode(allResponse.self, from: data!)
                    let f1ResultArray = response.f1Results
                    
                    
                    print("*****F1")
                    for i in f1ResultArray {
                        
                        print(i.publicationDate)
                        print(i.seconds)
                        print(i.tournament)
                        print(i.winner)
                        print("")
                    }


                    print("")
                    let tennisResultArray = response.Tennis
                    print("*******Teniis")
                    for i in tennisResultArray {

                        print(i.looser)
                        print(i.numberOfSets)
                        print(i.publicationDate)
                        print(i.tournament)
                        print(i.winner)
                        
                    }

                    print("")
                    let nbaResultArray = response.nbaResults
                    print("******NBA")
                    for i in nbaResultArray {

                        print(i.gameNumber)
                        print(i.looser)
                        print(i.publicationDate)
                        print(i.tournament)
                        print(i.winner)
                        print("")
                        
//                        let dateConverted = String2Date().getDate(strDate: i.publicationDate)
                        
                    }

                    print("")
                    print("********** mergedData *****************")
                    self.mergedData = f1ResultArray + tennisResultArray + nbaResultArray
                    print(self.mergedData)
                    print("")
                    print("+++++++++++++++")

                    
                    // Convert String publicationDate to Date/Time type
//                    for j in self.mergedData {
//                        guard let dateConverted = String2Date().getDate(strDate: j.publicationDate) else { return }
//                        print("j.publicationDate: \(j.publicationDate)")
//                        print("dateConverted: \(String(describing: dateConverted))")
//
//
////                        self.localData.append(j.publicationDate)
////                        self.localData.append(dateConverted)
//
//                    }
//
//                    print("")
//                    print("localData")
//                    print(self.localData)
                    
                    // Sort mergedData array by publicationDate
//                    let sortedData = self.mergedData.sorted {
//                        $0.publicationDate < $1.publicationDate
//                    }
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.timeZone = TimeZone(abbreviation: "UTF")
                    dateFormatter.dateFormat = "MM dd, yyyy HH:mm:ss a"
                    let sortedData = self.mergedData.sorted(by: { dateFormatter.date(from: $0.publicationDate)?.compare(dateFormatter.date(from: $1.publicationDate)!) == .orderedAscending })
                    
                    print("")
                    print("**************")
                    print(sortedData)
                    
                    
                } catch {
                    print("Error: \(error)")
                }

            }
        
        })
        task.resume()


//        let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>



    }
    
    
//    func merge<T>(_ arrays: [T]...) -> [T] {
//        guard let longest = arrays.max(by: { $0.count < $1.count })?.count else { return [] }
//        var result = [T]()
//        for index in 0..<longest {
//            for array in arrays {
//                guard index < array.count else { continue }
//                result.append(array[index])
//            }
//        }
//        return result
//    }
    
    
//    func postApiCall() {
//        guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts") else { return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let body: [String: AnyHashable] = [
//            "userId": 1,
//            "title": "Hello from iOS Academy",
//            "body": "Hello there?"
//        ]
//
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//
//        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
//            guard let data = data, error == nil else { return }
//            do {
//                let response = try JSONDecoder().decode(Response.self, from: data)
//                print(response)
//
////                let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
////                print(json)
//            } catch {
//                print(error)
//            }
//        }
//        task.resume()
//    }
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
//     postApiCall()
        getApiCall()
        
    }

}

//struct Response: Codable {
//    let body: String
//    let id: Int
//    let title: String
//    let userId: Int
//
//}

struct allResponse: Codable {
    let nbaResults: [nbaResults]
    let Tennis: [Tennis]
    let f1Results: [f1Results]
}



struct nbaResults: Codable {
    let gameNumber: Int
    let looser: String
    let mvp: String
    let publicationDate: String
    let tournament: String
    let winner: String
    
//    let numberOfSets: Int?
//    let seconds: Double?
}

struct Tennis: Codable {
    let looser: String
    let numberOfSets: Int
    let publicationDate: String
    let tournament: String
    let winner: String
    
//    let gameNumber: Int?
//    let mvp: String?
//    let seconds: Double?
}

struct f1Results: Codable {
    let publicationDate: String
    let seconds: Double
    let tournament: String
    let winner: String
    
//    let gameNumber: Int?
//    let looser: String?
//    let mvp: String?
//    let numberOfSets: Int?
}




protocol Item  {
//    var gameNumber: Int? { get }
//    var looser: String? { get }
//    var mvp: String? { get }
//    var numberOfSets: Int? { get }
    var publicationDate: String  { get }
//    var seconds: Double?  { get }
//    var tournament: String  { get }
//    var winner: String?  { get }
}

extension f1Results: Item {}
extension Tennis: Item {}
extension nbaResults: Item {}



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



/*
 +++++++++++++++
 May 9, 2020 8:09:03 PM
 Apr 14, 2020 8:09:03 PM
 Mar 15, 2020 8:09:03 PM
 May 9, 2020 11:15:15 PM
 May 9, 2020 2:00:40 PM
 May 8, 2020 4:33:17 PM
 May 9, 2020 9:15:15 AM
 May 7, 2020 3:15:00 PM
 May 5, 2020 1:34:15 PM
 May 3, 2020 9:15:33 PM
 May 2, 2020 6:07:03 AM

 +++++++++++++++
 Apr 14, 2020 8:09:03 PM
 Mar 15, 2020 8:09:03 PM
 May 2, 2020 6:07:03 AM
 May 3, 2020 9:15:33 PM
 May 5, 2020 1:34:15 PM
 May 7, 2020 3:15:00 PM
 May 8, 2020 4:33:17 PM
 May 9, 2020 11:15:15 PM
 May 9, 2020 2:00:40 PM
 May 9, 2020 8:09:03 PM
 May 9, 2020 9:15:15 AM
 */

class String2Date {
    
    func getDate(strDate: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd, yyyy HH:mm:ss a"
        let date = dateFormatter.date(from: strDate)
        
        return date
    }
    
}
