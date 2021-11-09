//
//  SpotsNewsViewController.swift
//  RM_REST_POST
//
//  Created by Tatsuya Moriguchi on 10/29/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit
import AVFoundation

class SportsNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var selectedIndexPath: IndexPath?
    
    // MARK: - Properties
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

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        title = "Tap Headline to Hear in Audio"

        pickerView.dataSource = self
        pickerView.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //tableView.estimatedRowHeight = UITableView.automaticDimension
        // Calling an extension funcion in GetApiCall.swift to get data from API
        self.getApiCall()
        
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SportsNewsTableViewCell
        cell.headLineLabel.text = dailyData[indexPath.row].headLine
        cell.dateLabel.text = dailyData[indexPath.row].publicationDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "toDetails", sender: self)
        
    }
    


// Segue
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Get the new view controller using segue.destination.
    if segue.identifier == "toDetails" {
        let detailsVC = segue.destination as! DetailsViewController
        
    // Pass the selected object to the new view controller.
        
        let int0 = selectedIndexPath?[0]
        let int1 = selectedIndexPath?[1]
  
        detailsVC.headLine = dailyData[int1!].headLine
        detailsVC.dateString = dailyData[int1!].publicationDate


    }
   }
}

// MARK: - UIPickerView
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
        
        dailyData = sortedData.filter { $0.date4PickerView == dateList[row] }
        tableView.reloadData()

    }

}

