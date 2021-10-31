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

    // sortedData is generated from getApiCall func of an extension in GetApiCall.swift
    var sortedData = [NewsData]()
    var dateList = [String]()

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
    
}

/*
 struct NewsData {
     let publicationDate: String
     let date4PickerView: String
     let headLine: String
 }
 */



//extension SportsNewsViewController {
//    
//    func extractDate4Picker(data: [NewsData]) -> Array<String> {
//        var output = [String]()
//        for i in data {
//            //if output.contains(i.date4PickerView) == false {
//            print("hello")
//            print(i.date4PickerView)
//            output.append(i.date4PickerView)
//            //}
//        }
//        print("output: \(output)")
//        return output
//    }
//}




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

}

