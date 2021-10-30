//
//  ViewController.swift
//  RM_REST_POST
//
//  Created by Tatsuya Moriguchi on 10/26/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var getNewsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        
        getNewsButton.setTitle("Get News", for: .normal)
        view.addSubview(getNewsButton)
        getNewsButton.backgroundColor = .white
        getNewsButton.setTitleColor(.black, for: .normal)
        getNewsButton.frame = CGRect(x: 100, y: 200, width: 200, height: 60)
        getNewsButton.layer.cornerRadius = 20
       

        
    }
   
}








