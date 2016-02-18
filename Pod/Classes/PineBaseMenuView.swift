//
//  KamaConfig.swift
//  KamaUIKit
//
//  Created by Prakash Raman on 13/02/16.
//  Copyright © 2016 1985. All rights reserved.
//

import Foundation
import UIKit


class PineBaseMenuView : UIView {
    
    var delegate : PineMenuDelegate?
    
    init(){
        super.init(frame: CGRect.zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        self.backgroundColor = UIColor.greenColor()
        let b = PineButton(title: "Call")
        self.addSubview(b)

        b.addTarget(self, action: "callme:", forControlEvents: .TouchUpInside)
    }

    func callme(sender: AnyObject?){
//        self.delegate?.loadContentViewController(ViewController2())
    }
    
}