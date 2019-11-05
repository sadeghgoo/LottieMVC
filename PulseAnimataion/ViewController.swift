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
        
        animationView.setupAnimation(animationName: "Halo", loopMode: .playOnce)
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
    
    func didAnimationFinished(lottieView: LottieAnimationView) {
        lottieView.pauseAnimation()
        
    }
    
    
    func didAnimationStatusChanged(status: AnimationStatus) {
        if status == .play {
            print("Wow im playing")
        }
    }
}

