//
//  ByvTransition.swift
//  Pods
//
//  Created by Adrian Apodaca on 25/11/16.
//
//

import Foundation


open class ByvTransition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    public var transitionDuration:TimeInterval = 0.3
    
    public var presenting:Bool = true
    public var opened:Bool = false
    
    public override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    public func rotated() {
        // override Me!!!
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    // MARK: - UIPercentDrivenInteractiveTransition
    
    var interactionInProgress = false
    
    private var shouldCompleteTransition = false

    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactionInProgress ? self : nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactionInProgress ? self : nil
    }
    
    
    public func wireTo(viewController: UIViewController!) {
        prepareGestureRecognizerIn(view: viewController.view)
    }
    
    public func wireTo(view: UIView!) {
        prepareGestureRecognizerIn(view: view)
    }
    
    func prepareGestureRecognizerIn(view: UIView) {
        
    }
    
    func handleGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        var progress = (translation.x / UIScreen.main.bounds.size.width)
        if opened {
            progress *= -1
        }
        
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        
        switch gestureRecognizer.state {
            
        case .began:
            interactionInProgress = true
            if !opened {
                startTransition()
            } else {
                closeTransition()
            }
            
        case .changed:
            shouldCompleteTransition = progress > 0.5
            update(progress)
            
        case .cancelled:
            interactionInProgress = false
            cancel()
            
        case .ended:
            interactionInProgress = false
            
            if !shouldCompleteTransition {
                cancel()
            } else {
                finish()
            }
            
        default:
            print("Unsupported")
        }
    }
    
    func startTransition() {
        
    }
    
    func closeTransition() {
        
    }
}
