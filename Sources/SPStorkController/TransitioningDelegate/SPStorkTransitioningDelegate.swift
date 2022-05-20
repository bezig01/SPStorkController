// The MIT License (MIT)
// Copyright © 2020 Ivan Vorobei (hello@ivanvorobei.by)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

public final class SPStorkTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    public var swipeToDismissEnabled: Bool = true
    public var tapAroundToDismissEnabled: Bool = true
    public var showCloseButton: Bool = false
    public var showIndicator: Bool = true
    public var indicatorColor: UIColor = UIColor.init(red: 202/255, green: 201/255, blue: 207/255, alpha: 1)
    public var hideIndicatorWhenScroll: Bool = false
    public var indicatorMode: SPStorkArrowMode = .auto
    public var customHeight: CGFloat? = nil
    public var translateForDismiss: CGFloat = 200
    public var cornerRadius: CGFloat = 10
    public var hapticMoments: [SPStorkHapticMoments] = [.willDismissIfRelease]
    public weak var storkDelegate: SPStorkControllerDelegate? = nil
    public weak var confirmDelegate: SPStorkControllerConfirmDelegate? = nil
    
    private let blurView = UIVisualEffectView(effect: nil)
    
    private lazy var propertyAnimator: UIViewPropertyAnimator? = {
        let animator = UIViewPropertyAnimator(duration: 0.6, dampingRatio: 1) {
            if #available(iOS 13.0, *) {
                self.blurView.effect = UIBlurEffect(style: .systemMaterial)
            } else {
                self.blurView.effect = UIBlurEffect(style: .regular)
            }
        }
        animator.pausesOnCompletion = true
        return animator
    }()
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let controller = SPStorkPresentationController(presentedViewController: presented, presenting: presenting)
        controller.swipeToDismissEnabled = self.swipeToDismissEnabled
        controller.tapAroundToDismissEnabled = self.tapAroundToDismissEnabled
        controller.showCloseButton = self.showCloseButton
        controller.showIndicator = self.showIndicator
        controller.indicatorColor = self.indicatorColor
        controller.hideIndicatorWhenScroll = self.hideIndicatorWhenScroll
        controller.indicatorMode = self.indicatorMode
        controller.customHeight = self.customHeight
        controller.translateForDismiss = self.translateForDismiss
        controller.cornerRadius = self.cornerRadius
        controller.hapticMoments = self.hapticMoments
        controller.transitioningDelegate = self
        controller.storkDelegate = self.storkDelegate
        controller.confirmDelegate = self.confirmDelegate
        return controller
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let controller = SPStorkPresentingAnimationController()
        controller.propertyAnimator = propertyAnimator
        controller.blurView = blurView
        return controller
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let controller = SPStorkDismissingAnimationController()
        controller.propertyAnimator = propertyAnimator
        return controller
    }
    
    deinit {
        print(String(describing: self), #function)
        
        propertyAnimator?.stopAnimation(false)
        propertyAnimator?.finishAnimation(at: .current)
    }
}
