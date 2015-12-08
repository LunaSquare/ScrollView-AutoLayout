//
//  SecondViewController.swift
//  ScrollView-AutoLayout
//
//  Created by Oliver Toscan on 08/12/15.
//  Copyright © 2015 Luna Square. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var dummyView: UIView!
    
    let colors = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.yellowColor()]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createScrollViewStructure()
    }

    
    func createScrollViewStructure() {
        // Number of tiles
        containerWidthConstraint.constraintWithMultiplier(1.0/CGFloat(colors.count))
        container.layoutIfNeeded()
        
        
        // Create the views
        var constraintsArray: [NSLayoutConstraint] = []
        var subviews: [UIView] = []
        
        for index in 0..<colors.count {
            // Configure subview
            let subview = UIView()
            subview.translatesAutoresizingMaskIntoConstraints = false
            subview.backgroundColor = colors[index]
            subviews.append(subview)
            container.addSubview(subview)
            
            
            // Add constraints to subview
            var views = ["D": self.dummyView, "S": subview]
            
            constraintsArray += NSLayoutConstraint.constraintsWithVisualFormat("H:[S(==D)]", options: [], metrics: nil, views: views)
            constraintsArray += NSLayoutConstraint.constraintsWithVisualFormat("V:[S(==D)]", options: [], metrics: nil, views: views)
            constraintsArray += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[S]", options: [], metrics: nil, views: views)
            
            if index == 0 {
                constraintsArray += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[S]", options: [], metrics: nil, views: views)
            } else {
                let leftHandView = subviews[index-1]
                views["LHV"] = leftHandView
                constraintsArray += NSLayoutConstraint.constraintsWithVisualFormat("H:[LHV]-0-[S]", options: [], metrics: nil, views: views)
            }
        }
       
        NSLayoutConstraint.activateConstraints(constraintsArray)
    }
}

