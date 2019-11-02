//
//  LottieAnimationView.swift
//  LottieAnimationView
//
//  Created by sadegh on 11/2/19.
//  Copyright © 2019 sadegh. All rights reserved.
//

import Foundation
import Lottie

class LottieAnimationView: UIView {
    
    enum AnimationStatus {
        case play
        case stop
        case pause
        case non
    }
    
    private lazy var animationView: AnimationView = {
        let animationView = AnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        return animationView
        
    }()
    
    private var animation: Animation!
    
    private var animationStatus: AnimationStatus = .non
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(animationView)
        animationView.clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(animationView)
        animationView.clipsToBounds = false

        
        NotificationCenter.default.addObserver(self, selector: #selector(LottieAnimationView.willEnterForegroundNotification) , name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LottieAnimationView.didEnterBackgroundNotification) , name: UIApplication.didEnterBackgroundNotification, object: nil)
        
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
        
    }
    override class func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @objc private func willEnterForegroundNotification() {
        print("willEnterForegroundNotification")
        
    }
    
    @objc private func didEnterBackgroundNotification() {
        print("didEnterBackgroundNotification")
    }
    /// this is intialize of lottie animation view
    func setupAnimation(animationName: String, loopMode: LottieLoopMode = .loop) {
        
         self.animation = Animation.named(animationName)
         animationView.loopMode = loopMode

    }
    
    
    func playAnimation(completion:(() -> Void)? = nil) {
        
        animationStatus = .play
        
        animationView.animation = self.animation
        
        animationView.play { (bool) in
            completion?()
        }
    }
    
    func pauseAnimation(completion:(() -> Void)? = nil) {
        
        animationStatus = .pause

        self.animationView.pause()
        completion?()
    }
    
    func stopAnimation(completion:(() -> Void)? = nil) {
        
        animationStatus = .stop
        
        self.animationView.stop()
        completion?()
    }
    
    
    fileprivate func setConstraint() {
        
        let animationViewConstraint: [NSLayoutConstraint] =
            [animationView.topAnchor.constraint(equalTo: topAnchor),
             animationView.bottomAnchor.constraint(equalTo: bottomAnchor),
             animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
             animationView.trailingAnchor.constraint(equalTo: trailingAnchor)]
        
        NSLayoutConstraint.activate(animationViewConstraint)
        
    }
    
}

