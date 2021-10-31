//
//  ViewController.swift
//  RM_REST_POST
//
//  Created by Tatsuya Moriguchi on 10/26/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController, CAAnimationDelegate, CALayerDelegate {
    
    
    // MARK: - ANIMATION
    // Declare a layer variable for animation
    var mask: CALayer?
    
    
    @IBOutlet weak var getNewsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        title = "No More Sleep Apnea"
        
        // Opening Animation
        maskView()
        animate()
        
        
        getNewsButton.setTitle("Get Sports News and Oxygen", for: .normal)
        view.addSubview(getNewsButton)
        getNewsButton.backgroundColor = .white
        getNewsButton.setTitleColor(.darkGray, for: .normal)
        // Centered horizontally and vertically by Autolayout on Storyboard
        //getNewsButton.frame = CGRect(x: 0, y: 0, width: 300, height: 60)
        getNewsButton.layer.cornerRadius = 20
        
    }
   
    
    // Create a layer
    func maskView() {
        self.mask = CALayer()
        self.mask!.contents = UIImage(named: "resmed-logo-transparency")!.cgImage
        self.mask!.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.mask!.position = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        view.layer.mask = mask
    }
    
    // Do Animation
    func animate() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 1
        
        keyFrameAnimation.duration = 2
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut), CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)]
        
        let initialBounds = NSValue(cgRect: mask!.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 60, height: 60))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 1500, height: 1500))
        keyFrameAnimation.values = [initialBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        self.mask!.add(keyFrameAnimation, forKey: "bounds")
        
    }
    
    // Remove sublayer after animation is done to expose login view
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        mask?.removeFromSuperlayer()
    }

}








