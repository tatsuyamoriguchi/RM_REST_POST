//
//  DataModel.swift
//  RM_REST_POST
//
//  Created by Tatsuya Moriguchi on 10/29/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import Foundation

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
}

struct Tennis: Codable {
    let looser: String
    let numberOfSets: Int
    let publicationDate: String
    let tournament: String
    let winner: String
}

struct f1Results: Codable {
    let publicationDate: String
    let seconds: Double
    let tournament: String
    let winner: String
}


struct NewsData {
    let publicationDate: String
    let date4PickerView: String
    let headLine: String
}



/*
 Compose sentences in UI for each sports category as follows:
 
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
 JSON format data by POST
 "https://ancient-wood-1161.getsandbox.com/results"
 
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
