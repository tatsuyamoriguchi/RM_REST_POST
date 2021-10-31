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
    @IBOutlet weak var pickerView: UIPickerView!

    // sortedData is generated from getApiCall func
    var sortedData = [NewsData]()
    // String date data, MMMMddyyyy will be stored in dateList array for pickerView
    var dateList = [String]()
    //
    var dateSelected: String = ""
    // NewsData array to filter news by date for tableView according to date selected in pickerView
    var dailyData = [NewsData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        title = "Sports News"

        pickerView.dataSource = self
        pickerView.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Calling an extension funcion in GetApiCall.swift to get data from API
        self.getApiCall()
//        dateSelected = dateList[0]
//        sortedData = sortedData.filter {$0.date4PickerView == dateSelected }

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = dailyData[indexPath.row].headLine
        cell.detailTextLabel?.text = dailyData[indexPath.row].publicationDate
        
        return cell
    }
    
}

extension SportsNewsViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dateList.count
    }
}

extension SportsNewsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return dateList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //newsList = sortedData[row]
    }

}

