//
//  NSLayoutConstraint-UpdateMultiplier.swift
//  Display
//
//  Created by Oliver Toscan on 30/10/15.
//  Copyright © 2015 Luna Square. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    func setMultiplier(_ multiplier:CGFloat) {
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        newConstraint.isActive = self.isActive
        
        NSLayoutConstraint.deactivate([self])
        NSLayoutConstraint.activate([newConstraint])
    }
    
    
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        self.isActive = false
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.isActive = true
        return newConstraint
    }
}
