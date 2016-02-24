//
//  PineSwipeView.swift
//  Pods
//
//  Created by Prakash Raman on 24/02/16.
//
//

import UIKit
import Foundation

public class PineSwipeView: UIView {
    
    public var stages : [UIView] = []
    public var onChange : (stage : Int) -> Void = {_ in}
    public var stage = 1
    

    public init(stages: [UIView] = [], onChange: ((stage: Int) -> Void)? = nil){
        super.init(frame: CGRect.zero)
        self.stages = stages.reverse()
        self.clipsToBounds = true
        if onChange != nil {
            self.onChange = onChange!
        }
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(){
        for view in self.stages {
            self.addSubview(view)
        }
        setupPan()
    }
    
    public func setupPan(){
    // REGISTERS THE PAN
        let pan = UIPanGestureRecognizer(target: self, action: "panning:")
        if self.stages.count == 0 {
            return
        }
        self.stages.last!.addGestureRecognizer(pan)
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        for view in self.stages {
            view.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        }
    }

    public func panning(pan: UIPanGestureRecognizer){
        let finger = pan.translationInView(pan.view)
        let view = pan.view
        var move = view?.frame
        move?.origin.x = finger.x
        view?.frame = move!
        
        if pan.state == .Ended {
            // CHECK IF THE SWIPE HAS BEEN MORE THAN HALF . ELSE REVERT
            if view?.frame.origin.x >= self.frame.width / 2 {
                nextView()
            } else {
                resetView()
            }
        }
    }
    
    public func resetView(){
        let v = self.stages.last
        UIView.animateWithDuration(0.3) { () -> Void in
            var f = v!.frame
            f.origin.x = 0
            v?.frame = f
        }
    }
    
    
    // MOVES THE VIEW COMPLETELY OUT
    // REMOVES FROM THE SUPER VIEW
    // REMOVES FROM THE SELF.stages
    // CALLS ONCHAGE
    // INCREMENTS "STAGE"
    public func nextView(){
        let view = self.stages.last
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            var f = view?.frame
            f?.origin.x = self.frame.width
            view?.frame = f!
        }) { (done) -> Void in
            view?.removeFromSuperview()
            self.stages.removeLast()
            self.setupPan() // SETUPS UP THE PAN FOR THE NEXT VIEW
            
            self.onChange(stage: self.stage)
            self.stage += 1
        }
    }
    
}
