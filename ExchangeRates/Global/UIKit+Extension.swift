//
//  UIExtensions.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

extension UIViewController {
    // https://www.swiftbysundell.com/posts/using-child-view-controllers-as-plugins-in-swift
    func add(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.view.bindFrameToSuperviewBounds()
        child.didMove(toParent: self)
    }

    func removeChild() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

extension UIView {

    static public var ReuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    static public var Nib: UINib {
        return UINib(nibName: ReuseIdentifier, bundle: nil)
    }

    func removeAllGestureRecognizers() {
        gestureRecognizers?.forEach { removeGestureRecognizer($0) }
    }


    /// Adds constraints to this `UIView` instances `superview` object to make sure this always has the same size as the superview.
    /// Please note that this has no effect if its `superview` is `nil` – add this `UIView` instance as a subview before calling this.
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
    }
}
