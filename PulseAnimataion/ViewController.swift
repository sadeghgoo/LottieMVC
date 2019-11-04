//
//  ViewController.swift
//  PulseAnimataion
//
//  Created by sadegh on 11/2/19.
//  Copyright © 2019 sadegh. All rights reserved.
//

import UIKit
import Lottie


class ViewController: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
        
    @IBOutlet weak var frontView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.setupAnimation(animationName:"circle")
        frontView.layer.cornerRadius = 100
        
    }

    @IBAction func play(_ sender: Any) {
        animationView.playAnimation()
        
        
    }
    
    @IBAction func puse(_ sender: Any) {
        animationView.pauseAnimation()
        
    }
    
    @IBAction func stop(_ sender: Any) {
        animationView.stopAnimation()
       
    }
}

