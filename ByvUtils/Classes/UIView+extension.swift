//
//  UIView+extension.swift
//  Pods
//
//  Created by Adrian Apodaca on 28/11/16.
//
//

import Foundation

public class PreHiddenData {
    static public var assoKey: UInt8 = 0
    var newConstraints:[NSLayoutConstraint] = []
    var oldConstraints:[NSLayoutConstraint] = []
}

public enum ByvPosition {
    case top
    case right
    case bottom
    case left
    case all
}

public enum ByvDirection {
    case vertical
    case horizontal
}


public extension UIView {
    
    var preHiddenData: PreHiddenData {
        get {
            return associatedObject(base:self, key: &PreHiddenData.assoKey)
            { return PreHiddenData() } // Set the initial value of the var
        }
        set { associateObject(base:self, key: &PreHiddenData.assoKey, value: newValue) }
    }
    
    func addTo(_ superView: UIView, position:ByvPosition = .all, insets: UIEdgeInsets = UIEdgeInsets.zero, centered:Bool = false, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        let views = ["view" : self]
        
        var formatString = "H:"
        
        if position == .left || ((position == .top || position == .bottom || position == .all) && !centered) {
            formatString += "|-(\(insets.left))-"
        }
        
        formatString += "[view"
        
        if let width = width {
            formatString += "(\(width))"
        }
        
        formatString += "]"
        
        if position == .right || ((position == .top || position == .bottom || position == .all) && !centered) {
            formatString += "-(\(insets.right))-|"
        }
        
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: formatString, options:[] , metrics: nil, views: views)
        
        NSLayoutConstraint.activate(constraints)
        
        if centered && position != .left && position != .right {
            superView.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        }
        
        formatString = "V:"
        
        if position == .top || ((position == .left || position == .right || position == .all) && !centered) {
            formatString += "|-(\(insets.top))-"
        }
        
        formatString += "[view"
        
        if let height = height {
            formatString += "(\(height))"
        }
        
        formatString += "]"
        
        if position == .bottom || ((position == .left || position == .right || position == .all) && !centered) {
            formatString += "-(\(insets.bottom))-|"
        }
        
        constraints = NSLayoutConstraint.constraints(withVisualFormat: formatString, options:[] , metrics: nil, views: views)
        
        NSLayoutConstraint.activate(constraints)
        
        if centered && position != .top && position != .left {
            superView.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0))
        }
        
    }
    
    func add(subViews:Array<UIView>, direction:ByvDirection = .vertical, insets: UIEdgeInsets = UIEdgeInsets.zero, margin: CGFloat = 0.0, size: CGFloat? = nil) {
        
        var preView: UIView? = nil
        
        for view in subViews {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            var views = ["view" : view]
            if let preView = preView {
                views = ["view" : view, "preView": preView]
            }
            var formatString = "H:"
            if direction == .horizontal {
                formatString = "V:"
            }
            
            formatString += "|-(\(insets.left))-[view]-(\(insets.right))-|"
            var constraints = NSLayoutConstraint.constraints(withVisualFormat: formatString, options:[] , metrics: nil, views: views)
            
            NSLayoutConstraint.activate(constraints)
            
            formatString = "V:"
            if direction == .horizontal {
                formatString = "H:"
            }
            
            if preView != nil {
                formatString += "[preView]-(\(margin))-"
            } else {
                formatString += "|-(\(insets.top))-"
            }
            
            formatString += "[view"
            
            if let _size = size {
                formatString += "(\(_size))"
            }
            
            formatString += "]"
            
            if view == subViews.last {
                formatString += "-(\(insets.bottom))-|"
            }
            
            constraints = NSLayoutConstraint.constraints(withVisualFormat: formatString, options:[] , metrics: nil, views: views)
            
            NSLayoutConstraint.activate(constraints)
            
            preView = view
        }
    }
    
    func setHeight(_ height: CGFloat, relation:NSLayoutRelation = .equal) {
        if let hc = self.height() {
            if hc.relation == relation {
                hc.constant = height
                return
            }
        }
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.height, relatedBy: relation, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height)
        self.addConstraint(heightConstraint)
    }
    
    func height() -> NSLayoutConstraint? {
        return getConstraint(attribute: .height)
    }
    
    func setWidth(_ width: CGFloat, relation:NSLayoutRelation = .equal) {
        if let wc = self.width() {
            if wc.relation == relation {
                wc.constant = width
                return
            }
        }
        let widthConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.width, relatedBy: relation, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: width)
        self.addConstraint(widthConstraint)
    }
    
    func width() -> NSLayoutConstraint? {
        return getConstraint(attribute: .width)
    }
    
    private func getConstraint(attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        var priority:Float = -1.0
        var response:NSLayoutConstraint? = nil
        
        for constraint in getConstraints(attribute: attribute) {
            if constraint.priority > priority {
                priority = constraint.priority
                response = constraint
            }
        }
        
        return response
    }
    
    private func getConstraints(attribute: NSLayoutAttribute) -> [NSLayoutConstraint] {
        var result:[NSLayoutConstraint] = []
        if attribute == .width || attribute == .height {
            for constraint in self.constraints {
                if constraint.firstAttribute == attribute {
                    result.append(constraint)
                }
            }
        } else {
            if let sv = self.superview {
                for constraint in sv.constraints {
                    if constraint.firstItem === self && constraint.firstAttribute == attribute {
                        result.append(constraint)
                    }
                    if constraint.secondItem === self && constraint.secondAttribute == attribute {
                        result.append(constraint)
                    }
                }
            }
        }
        return result
    }
    
    func addShadow(color: UIColor = UIColor.black, opacity: Float = 0.8, offset: CGSize = CGSize.zero, radius: CGFloat = 10.0 ) {
        self.clipsToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
    }
    
    func indexPath(for tableView: UITableView) -> IndexPath? {
        var view:UIView? = self
        while (view != nil) {
            if view!.isKind(of: UITableViewCell.classForCoder()) {
                return tableView.indexPath(for: view as! UITableViewCell)
            } else {
                if let sv = view?.superview {
                    view = sv
                } else {
                    view = nil
                }
            }
        }
        
        return nil;
    }
    
    func top() -> NSLayoutConstraint? {
        return getConstraint(attribute: .top)
    }
    
    func bottom() -> NSLayoutConstraint? {
        return getConstraint(attribute: .bottom)
    }
    
    func left() -> NSLayoutConstraint? {
        return getConstraint(attribute: .leading)
    }
    
    func rigth() -> NSLayoutConstraint? {
        return getConstraint(attribute: .trailing)
    }
    
    func hideInVertical(margin:Double, animated:Bool = false) {
        if let top = self.top(), let bottom = self.bottom() {
            var topItem = top.firstItem
            if topItem === self, let item = top.secondItem {
                topItem = item
            }
            var bottomItem = bottom.firstItem
            if bottomItem === self, let item = bottom.secondItem {
                bottomItem = item
            }
            
            self.preHiddenData.oldConstraints = [top, bottom]
            
            superview?.removeConstraints(preHiddenData.oldConstraints)
            
            
            let views = ["top": topItem, "bottom": bottomItem]
            var formatString = "V:"
            if topItem === superview {
                formatString += "|-"
            } else {
                formatString += "[top]-"
            }
            formatString += "(\(margin))"
            if bottomItem === superview {
                formatString += "-|"
            } else {
                formatString += "-[bottom]"
            }
            let constraints = NSLayoutConstraint.constraints(withVisualFormat: formatString, options:[] , metrics: nil, views: views)
            
            self.preHiddenData.newConstraints = constraints
            
            NSLayoutConstraint.activate(constraints)
        }
        if (animated) {
            UIView.animate(withDuration: 0.3) {
                self.superview?.layoutIfNeeded()
            }
        }
        self.isHidden = true
    }
    
    func showInVertical(animated:Bool = false) {
        superview?.removeConstraints(self.preHiddenData.newConstraints)
        superview?.addConstraints(self.preHiddenData.oldConstraints)
        self.preHiddenData = PreHiddenData()
        if (animated) {
            UIView.animate(withDuration: 0.3) {
                self.superview?.layoutIfNeeded()
            }
        }
        self.isHidden = false
    }
    
    func removeInVertical(margin:Double) {
        if let top = self.top(), let bottom = self.bottom() {
            var topItem = top.firstItem
            if topItem === self, let item = top.secondItem {
                topItem = item
            }
            var bottomItem = bottom.firstItem
            if bottomItem === self, let item = bottom.secondItem {
                bottomItem = item
            }
            
            let views = ["top": topItem, "bottom": bottomItem]
            var formatString = "V:"
            if topItem === superview {
                formatString += "|-"
            } else {
                formatString += "[top]-"
            }
            formatString += "(\(margin))"
            if bottomItem === superview {
                formatString += "-|"
            } else {
                formatString += "-[bottom]"
            }
            let constraints = NSLayoutConstraint.constraints(withVisualFormat: formatString, options:[] , metrics: nil, views: views)
            
            self.removeFromSuperview()
            
            NSLayoutConstraint.activate(constraints)
        }
    }
    
    func insertVetical(in sv:UIView, top:UIView?, bottom:UIView?, insets:UIEdgeInsets) {
        var topItem = sv
        if let top = top {
            topItem = top
        }
        var bottomItem = sv
        if let bottom = bottom {
            bottomItem = bottom
        }
        
        if let const = top?.bottom() {
            sv.removeConstraint(const)
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        sv.addSubview(self)
        let views = ["top": topItem, "bottom": bottomItem, "view": self]
        var formatString = "V:"
        if topItem === sv {
            formatString += "|-"
        } else {
            formatString += "[top]-"
        }
        formatString += "(\(insets.top))-[view]-(\(insets.bottom))"
        if bottomItem === sv {
            formatString += "-|"
        } else {
            formatString += "-[bottom]"
        }
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: formatString, options:[] , metrics: nil, views: views)
        
        NSLayoutConstraint.activate(constraints)
        
        formatString = "H:|-(\(insets.left))-[view]-(\(insets.right))-|"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: formatString, options:[] , metrics: nil, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func hideInHorizontal(margin:Double, animated:Bool = false) {
        if let top = self.left(), let bottom = self.rigth() {
            var topItem = top.firstItem
            if topItem === self, let item = top.secondItem {
                topItem = item
            }
            var bottomItem = bottom.firstItem
            if bottomItem === self, let item = bottom.secondItem {
                bottomItem = item
            }
            
            self.preHiddenData.oldConstraints = [top, bottom]
            
            superview?.removeConstraints(preHiddenData.oldConstraints)
            
            let views = ["top": topItem, "bottom": bottomItem]
            var formatString = "H:"
            if topItem === superview {
                formatString += "|-"
            } else {
                formatString += "[top]-"
            }
            formatString += "(\(margin))"
            if bottomItem === superview {
                formatString += "-|"
            } else {
                formatString += "-[bottom]"
            }
            let constraints = NSLayoutConstraint.constraints(withVisualFormat: formatString, options:[] , metrics: nil, views: views)
            
            self.preHiddenData.newConstraints = constraints
            
            NSLayoutConstraint.activate(constraints)
        }
        if (animated) {
            UIView.animate(withDuration: 0.3) {
                self.superview?.layoutIfNeeded()
            }
        }
        self.isHidden = true
    }
    
    func showInHorizontal(animated:Bool = false) {
        superview?.removeConstraints(self.preHiddenData.newConstraints)
        superview?.addConstraints(self.preHiddenData.oldConstraints)
        self.preHiddenData = PreHiddenData()
        if (animated) {
            UIView.animate(withDuration: 0.3) {
                self.superview?.layoutIfNeeded()
            }
        }
        self.isHidden = false
    }
    
    func removeInHorizontal(margin:Double) {
        if let top = self.left(), let bottom = self.rigth() {
            var topItem = top.firstItem
            if topItem === self, let item = top.secondItem {
                topItem = item
            }
            var bottomItem = bottom.firstItem
            if bottomItem === self, let item = bottom.secondItem {
                bottomItem = item
            }
            
            let views = ["top": topItem, "bottom": bottomItem]
            var formatString = "H:"
            if topItem === superview {
                formatString += "|-"
            } else {
                formatString += "[top]-"
            }
            formatString += "(\(margin))"
            if bottomItem === superview {
                formatString += "-|"
            } else {
                formatString += "-[bottom]"
            }
            let constraints = NSLayoutConstraint.constraints(withVisualFormat: formatString, options:[] , metrics: nil, views: views)
            
            self.removeFromSuperview()
            
            NSLayoutConstraint.activate(constraints)
        }
    }
    
    func insertHorizontal(in sv:UIView, left:UIView?, right:UIView?, insets:UIEdgeInsets) {
        var topItem = sv
        if let left = left {
            topItem = left
        }
        var bottomItem = sv
        if let right = right {
            bottomItem = right
        }
        
        if let const = left?.rigth() {
            sv.removeConstraint(const)
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        sv.addSubview(self)
        let views = ["top": topItem, "bottom": bottomItem, "view": self]
        var formatString = "H:"
        if topItem === sv {
            formatString += "|-"
        } else {
            formatString += "[top]-"
        }
        formatString += "(\(insets.top))-[view]-(\(insets.bottom))"
        if bottomItem === sv {
            formatString += "-|"
        } else {
            formatString += "-[bottom]"
        }
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: formatString, options:[] , metrics: nil, views: views)
        
        NSLayoutConstraint.activate(constraints)
        
        formatString = "V:|-(\(insets.left))-[view]-(\(insets.right))-|"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: formatString, options:[] , metrics: nil, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
}
