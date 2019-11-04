//
//  LottieAnimationView.swift
//  LottieAnimationView
//
//  Created by sadegh on 11/2/19.
//  Copyright © 2019 sadegh. All rights reserved.
//

import Foundation
import Lottie

/**

Create a view and subclasss it to LottieAnimationView then call setupAnimation method to Initalize Animation

 **Check This Eample :**
     
 This method like Intializer And should call
 
     animationView.setupAnimation(animationName: "AnimationName")
     

 Play animation
 
     animationView.playAnimation()
    
 Pause animation
 
     animationView.pauseAnimation()
     
 Stop animation
 
     animationView.stopAnimation()
    
 
 */

class LottieAnimationView: UIView {
    
    private enum AnimationStatus {
        case play
        case stop
        case pause
        case non
    }
    
    private lazy var animationView: AnimationView = {
        let animationView = AnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.clipsToBounds = false
        return animationView
        
    }()
    
    private var animation: Animation!
    
    private var animationStatus: AnimationStatus = .non
        
    /// This is intialize of lottie animation view
     func setupAnimation(animationName: String, loopMode: LottieLoopMode = .loop) {
         
          self.animation = Animation.named(animationName)
          animationView.loopMode = loopMode
          animationView.animation = self.animation
     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(animationView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(animationView)

        NotificationCenter.default.addObserver(self, selector: #selector(LottieAnimationView.willEnterForegroundNotification) , name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LottieAnimationView.didEnterBackgroundNotification) , name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
        
    }
    
    @objc private func willEnterForegroundNotification() {
        print("willEnterForegroundNotification")
        self.playAnimation()
        
    }
    
    @objc private func didEnterBackgroundNotification() {
        print("didEnterBackgroundNotification")
        self.pauseAnimation()
    }
}

extension LottieAnimationView {
    
    /// Play animation at time if animation is paused this method resume it
    func playAnimation(completion:(() -> Void)? = nil) {
        
        animationStatus = .play
    
        animationView.play { (bool) in
            completion?()
        }
    }
    /// Pause the animation at time
    func pauseAnimation(completion:(() -> Void)? = nil) {
        
        animationStatus = .pause
        self.animationView.pause()
        completion?()
    }
    /// Stop animation at time
    func stopAnimation(completion:(() -> Void)? = nil) {
        
        animationStatus = .stop
        
        self.animationView.stop()
        completion?()
    }
}

extension LottieAnimationView {
    
    //Set constraint to animationview
    fileprivate func setConstraint() {
          
          let animationViewConstraint: [NSLayoutConstraint] =
              [animationView.topAnchor.constraint(equalTo: topAnchor),
               animationView.bottomAnchor.constraint(equalTo: bottomAnchor),
               animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
               animationView.trailingAnchor.constraint(equalTo: trailingAnchor)]
          
          NSLayoutConstraint.activate(animationViewConstraint)
          
      }
}

