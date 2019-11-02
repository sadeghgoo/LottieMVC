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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.setupAnimation(animationName:"Halo")

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

