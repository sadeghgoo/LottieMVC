//
//  LottieAnimationView.swift
//  LottieAnimationView
//
//  Created by sadegh on 11/2/19.
//  Copyright © 2019 sadegh. All rights reserved.
//

import Foundation
import Lottie


// animation view status
enum AnimationStatus {
      case play
      case stop
      case pause
      case non
}

protocol LottieAnimationViewDelegate: class {
    func didAnimationStatusChanged(status: AnimationStatus)
}

/**
Create a view and subclasss it to LottieAnimationView then call setupAnimation method to Initalize Animation

 # Check This Eample :
     
 This method like Intializer And should call
```
animationView.setupAnimation(animationName: "AnimationName")
```
 + Play animation
 ```
animationView.playAnimation()
```
 + Pause animation
```
animationView.pauseAnimation()
```
 + Stop animation
```
animationView.stopAnimation()
```
 */
class LottieAnimationView: UIView {
    
    private lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: "", animationCache: LRUAnimationCache.sharedCache)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.clipsToBounds = false
        
        return animationView
        
    }()
    
    weak var lottieDelegate: LottieAnimationViewDelegate?
    
    private var animation: Animation!
    
    private var didAnimationPlayed: Bool = false

    /** Current status of animation */
    private var animationStatus: AnimationStatus {
        return .non
    }
        
    /** This method is like Intializer of class and you should call it when you want create animation  */
    /// - parameter animationName: animation name in current bundle
    /// - parameter loopMode: loop mode of animatoin default is infinity loop 
    func setupAnimation(animationName: String, loopMode: LottieLoopMode = .loop, animationSpeed: CGFloat = 1) {
        
        self.animation = Animation.named(animationName)
        animationView.loopMode = loopMode
        animationView.animation = self.animation
        self.animationView.animationSpeed = animationSpeed
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(animationView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LottieAnimationView.willEnterForegroundNotification) , name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LottieAnimationView.didEnterBackgroundNotification) , name: UIApplication.didEnterBackgroundNotification, object: nil)
        
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
    // Play animation willEnterForegroundNotification
    @objc private func willEnterForegroundNotification() {
        print("willEnterForegroundNotification")
        if self.didAnimationPlayed {
            self.playAnimation()

        }
        
    }
    // Puase animation didEnterBackgroundNotification
    @objc private func didEnterBackgroundNotification() {
        print("didEnterBackgroundNotification")
        self.didAnimationPlayed = true
        self.pauseAnimation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension LottieAnimationView {
    
    /** Play animation when animation is paused this method resume it */
    /// - parameter completion: do something after play animation
    func playAnimation(completion:(() -> Void)? = nil) {
        
        lottieDelegate?.didAnimationStatusChanged(status: .play)
        animationView.play()
        completion?()

    }
    /** Pause animation at time */
    /// - parameter completion: do something after pause animation
    func pauseAnimation(completion:(() -> Void)? = nil) {
        
        lottieDelegate?.didAnimationStatusChanged(status: .pause)
        self.animationView.pause()
        completion?()
    }
    /** Stop animation at time */
    /// - parameter completion: do something after stop animation
    func stopAnimation(completion:(() -> Void)? = nil) {
        
        lottieDelegate?.didAnimationStatusChanged(status: .stop)
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

