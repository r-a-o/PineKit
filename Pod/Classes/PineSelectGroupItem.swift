//
//  Button.swift
//  Petter
//
//  Created by Prakash Raman on 08/02/16.
//  Copyright © 2016 1985. All rights reserved.
//

import UIKit
import SnapKit

public class PineSelectGroupItem : UIView {
        
    public var data : Dictionary<String, String> = Dictionary<String, String>()
    
    public enum State {
        case Active, Inactive
    }
    
    let label = UILabel()
    let icon = PineIcon(named: "checkbox_inactive")
    var text: String = ""
    var value: String = ""
    var state: State = .Inactive
    var group: PineSelectGroup? = nil
    
    
    public init(data: Dictionary<String, String>, group: PineSelectGroup){
        super.init(frame: CGRect.zero)
        self.data = data
        self.text = data["text"] ?? ""
        self.value = data["value"] ?? ""
        self.group = group
        
        setup()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(){
        self.addSubview(self.label)
        self.addSubview(self.icon)
        
        drawSelf()
        observeTouch()
        update()
    }
    
    public func drawSelf(){
        drawLabel()
        drawIcon()
    }
    
    public func drawLabel(){
        self.label.snp_makeConstraints { (make) -> Void in
            make.centerY.left.equalTo(self)
        }
    }
    
    public func drawIcon(){
        self.icon.snp_makeConstraints { (make) -> Void in
            make.right.centerY.equalTo(self)
            make.size.equalTo(PineConfig.Size.icon)
        }
    }
    
    func observeTouch(){
        let gesture = UITapGestureRecognizer(target: self, action: "tapped:")
        self.addGestureRecognizer(gesture)
    }
    
    func tapped(sender: UITapGestureRecognizer? = nil){
        let s : State = (self.state == .Active) ? .Inactive : .Active
        set(state: s).beforeUpdate().update()
        self.group?.onSelection()
    }
    
    public func set(state state: State) -> PineSelectGroupItem {
        self.state = state
        return self
    }
    
    public func isActive() -> Bool {
        return self.state == .Active ? true : false
    }
    
    public func beforeUpdate() -> PineSelectGroupItem {
        return self
    }
    
    public func update(){
        self.label.text = self.text
        let iconname = self.isActive() ? "checkbox_active" : "checkbox_inactive"
        self.icon.change(named: iconname)
    }
    
}