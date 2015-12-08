//
//  NSLayoutConstraint-UpdateMultiplier.swift
//  Display
//
//  Created by Oliver Toscan on 30/10/15.
//  Copyright © 2015 Luna Square. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    func setMultiplier(multiplier:CGFloat) {
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
        newConstraint.active = self.active
        
        NSLayoutConstraint.deactivateConstraints([self])
        NSLayoutConstraint.activateConstraints([newConstraint])
    }
    
    
    func constraintWithMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        self.active = false
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.active = true
        return newConstraint
    }
}