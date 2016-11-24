//
//  MenuPresent.swift
//  Pods
//
//  Created by Adrian Apodaca on 21/11/16.
//
//

import Foundation
import QuartzCore

open class MenuTransition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    public var transitionDuration:TimeInterval = 0.3
    public var menuWidthPecent:CGFloat = 0.10
    public var menuScale:CGFloat = 0.3
    
    public var presenting:Bool = true
    public var opened:Bool = false
    
    public var onWideOpen: (() -> Void)? = nil
    
    private var preStatusBarStyle = UIApplication.shared.statusBarStyle
    private var outViewController:UIViewController? = nil
    private var outView:UIView? = nil
    
    public override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    public func rotated() {
        if opened {
            print("ROTATED!!")
            print("bounds: \(UIScreen.main.bounds)")
            let snap = outViewController?.view.snapshotView(afterScreenUpdates: true)!
            snap?.frame = (outView?.bounds)!
            snap?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            outView?.addSubview(snap!)
        }
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
        if self.presenting {
            self.showMenu(withTransaction: transitionContext)
        }
        else {
            if (self.onWideOpen != nil) {
                self.openWide(withTransaction: transitionContext)
            } else {
                self.closeMenu(withTransaction: transitionContext)
            }
        }
    }
    
    func showMenu(withTransaction transitionContext: UIViewControllerContextTransitioning) {
        guard let _vc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let menuVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        
        menuVc.view.frame = UIScreen.main.bounds
        
        outViewController = _vc
        outView = outViewController?.view.snapshotView(afterScreenUpdates: true)
        outView?.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin, .flexibleBottomMargin]
        outView?.frame = UIScreen.main.bounds
        self.updateOutView()
        
        transitionContext.containerView.addSubview(menuVc.view)
        
        transitionContext.containerView.addSubview(outView!)
        
        UIView.animateKeyframes(
            withDuration: transitionDuration,
            delay: 0,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
                    var frame = UIScreen.main.bounds
                    frame.size.width *= self.menuScale
                    frame.size.height *= self.menuScale
                    frame.origin.y = (UIScreen.main.bounds.size.height - frame.size.height) / 2.0
                    frame.origin.x = UIScreen.main.bounds.size.width - (UIScreen.main.bounds.size.width * self.menuWidthPecent)
                    self.outView?.frame = frame
                })
        },
            completion: { _ in
                if transitionContext.transitionWasCancelled {
                    self.opened = false
                    transitionContext.completeTransition(false)
                } else {
                    self.opened = true
                    self.prepareGestureRecognizerInView(view: self.outView!)
                    transitionContext.completeTransition(true)
                }
        })
    }
    
    func closeMenu(withTransaction transitionContext: UIViewControllerContextTransitioning) {
        guard let newVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        
        outViewController = newVc
        let snap = newVc.view.snapshotView(afterScreenUpdates: true)!
        snap.frame = (outView?.bounds)!
        snap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        outView?.addSubview(snap)
        
        UIView.animateKeyframes(
            withDuration: transitionDuration,
            delay: 0,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
                    self.outView?.frame = UIScreen.main.bounds
                    newVc.view.frame = UIScreen.main.bounds
                })
        },
            completion: { _ in
                if transitionContext.transitionWasCancelled {
                    self.opened = true
                    transitionContext.completeTransition(false)
                } else {
                    self.opened = false
                    self.outView?.removeFromSuperview()
                    self.outView = nil
                    transitionContext.completeTransition(true)
                }
        })
    }
    
    func openWide(withTransaction transitionContext: UIViewControllerContextTransitioning) {
        
        UIView.animateKeyframes(
            withDuration: transitionDuration,
            delay: 0,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
                    var frame = self.outView?.frame
                    frame?.origin.x = UIScreen.main.bounds.size.width
                    self.outView?.frame = frame!
                })
        },
            completion: { _ in
                
                if let completion = self.onWideOpen {
                    completion()
                }
                self.onWideOpen = nil
                self.closeMenu(withTransaction: transitionContext)
        })
    }
    
    func tappedOut(_ sender: Any) {
        ByvMenuNavigationViewController.closeMenu()
    }
    
    func updateOutView() {
        outView?.backgroundColor = UIColor.clear
        let outTap = UITapGestureRecognizer(target: self, action: #selector(tappedOut))
        outView?.addGestureRecognizer(outTap)
        outView?.layer.shadowColor = UIColor.black.cgColor
        outView?.layer.shadowOpacity = 0.3
        outView?.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactionInProgress ? self : nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactionInProgress ? self : nil
    }
    
    var interactionInProgress = false
    
    private var shouldCompleteTransition = false
    
    public func wireToViewController(viewController: UIViewController!) {
        prepareGestureRecognizerInView(view: viewController.view)
    }
    
    private func prepareGestureRecognizerInView(view: UIView) {
        if opened {
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(gestureRecognizer:)))
            view.addGestureRecognizer(gesture)
        } else {
            let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(gestureRecognizer:)))
            gesture.edges = UIRectEdge.left
            view.addGestureRecognizer(gesture)
        }
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
                ByvMenuNavigationViewController.showMenu()
            } else {
                ByvMenuNavigationViewController.closeMenu()
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
}
