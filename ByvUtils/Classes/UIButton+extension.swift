//
//  UIButton+extension.swift
//  ByvUtils
//
//  Created by Adrian Apodaca on 9/5/18.
//

import Foundation

public extension UIButton {
    private func actionHandleBlock(action:(() -> Void)? = nil) {
        struct __ {
            static var action :(() -> Void)?
        }
        if action != nil {
            __.action = action
        } else {
            __.action?()
        }
    }
    
    @objc private func triggerActionHandleBlock() {
        self.actionHandleBlock()
    }
    
    public func actionHandle(controlEvents control :UIControlEvents, ForAction action:@escaping () -> Void) {
        self.actionHandleBlock(action: action)
        self.addTarget(self, action: #selector(UIButton.triggerActionHandleBlock), for: control)
    }
    
    public func onClick(_ action:@escaping () -> Void) {
        self.actionHandle(controlEvents: .touchUpInside, ForAction: action)
    }
}
