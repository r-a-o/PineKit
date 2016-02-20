//
//  Button.swift
//  Petter
//
//  Created by Prakash Raman on 08/02/16.
//  Copyright © 2016 1985. All rights reserved.
//

import UIKit
import SnapKit

extension UI {

    class Icon: UIImageView {
        
        var named : String = "1x1"
        
        init(named name: String){
            super.init(frame: CGRect.zero)
            self.image = UIImage(named: name)
            self.contentMode = UIViewContentMode.Center
            self.named = name
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func change(named name: String){
            self.named = name
            self.image = UIImage(named: name)
        }
    }
    
}