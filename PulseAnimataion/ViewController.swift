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
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var frontView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageview.image = UIImage(named: "map")
        imageview.layer.cornerRadius = 100
        imageview.contentMode = .scaleAspectFill
        animationView.setupAnimation(animationName: <#T##String#>, loopMode: <#T##LottieLoopMode#>, animationSpeed: <#T##CGFloat#>)
        frontView.layer.cornerRadius = 100
        animationView.lottieDelegate = self
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
extension ViewController: LottieAnimationViewDelegate {
    
    func didAnimationStatusChanged(status: AnimationStatus) {
        if status == .play {
            print("Wow im playing")
        }
    }
}

