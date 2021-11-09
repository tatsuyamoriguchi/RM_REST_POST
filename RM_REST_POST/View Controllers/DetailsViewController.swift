//
//  DetailsViewController.swift
//  RM_REST_POST
//
//  Created by Tatsuya Moriguchi on 11/8/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var headLine: String?
    var dateString: String?
    
    
    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headLineLabel.text = headLine
        dateLabel.text = dateString
        
        Text2Speech().text2Speech(text: headLine!)
            
        
    }
    
}
