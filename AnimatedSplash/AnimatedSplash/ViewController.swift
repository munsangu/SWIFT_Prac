//
//  ViewController.swift
//  AnimatedSplash
//
//  Created by 문상우 on 2023/06/20.
//

import UIKit

class ViewController: UIViewController {
    
    var mask: CALayer?
    
    override var prefersStatusBarHidden: Bool {
        
        return true
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        self.mask = CALayer()
        self.mask!.contents = UIImage(named: "twitter")?.cgImage
        self.mask!.contentsGravity = CALayerContentsGravity.resizeAspect
        self.mask!.bounds = CGRect(x: 0, y: 0, width: 100, height: 81)
        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        self.mask!.position = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        self.view.layer.mask = mask
      
        self.animateMask()
        
    }

    private func animateMask() {
        
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 0.6
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.5
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),
                                             CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)]
        do {
            keyFrameAnimation.fillMode = CAMediaTimingFillMode.forwards
            keyFrameAnimation.isRemovedOnCompletion = false
        }
        let initalBounds = NSValue(cgRect: mask!.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 90*0.9, height: 73*0.9))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 1600, height: 1300))
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        self.mask!.add(keyFrameAnimation, forKey: "bounds")
        
    }
    
}

extension ViewController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.view.layer.mask = nil
    }
    
}
