//
//  FourthViewController.swift
//  ScrollView-AutoLayout
//
//  Created by Oliver Toscan on 08/12/15.
//  Copyright © 2015 Luna Square. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    let colors = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.yellowColor(), UIColor.orangeColor()]
    let container = UIView()
    let dummyView = UIView()
    let scrollView = UIScrollView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createScrollViewStructure()
        createSubviews()
    }
    
    
    func createScrollViewStructure() {
        // DummyView
        dummyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dummyView)
        
        // ScrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.pagingEnabled = true
        dummyView.addSubview(scrollView)
        
        // Container
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.purpleColor()
        scrollView.addSubview(container)
        
        
        var constraints: [NSLayoutConstraint] = []
        let views = ["D":dummyView, "S":scrollView, "C":container]
        
        // Dummy Constraints
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[D]-0-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[D(150)]", options: [], metrics: nil, views: views)

        // ScrollView Contraints
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[S]-0-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[S]-0-|", options: [], metrics: nil, views: views)

        // Container Constraints
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[C]-0-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[C(==D)]-0-|", options: [], metrics: nil, views: views)

        constraints += [NSLayoutConstraint(item: dummyView, attribute: .Width, relatedBy: .Equal,
                                          toItem: container, attribute: .Width, multiplier: 1/CGFloat(colors.count), constant: 0)]

        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    
    func createSubviews() {
        // Create subviews
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
            var views = ["D": dummyView, "SUB": subview]
            
            constraintsArray += NSLayoutConstraint.constraintsWithVisualFormat("H:[SUB(==D)]", options: [], metrics: nil, views: views)
            constraintsArray += NSLayoutConstraint.constraintsWithVisualFormat("V:[SUB(==D)]", options: [], metrics: nil, views: views)
            constraintsArray += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[SUB]", options: [], metrics: nil, views: views)
            
            if index == 0 {
                constraintsArray += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[SUB]", options: [], metrics: nil, views: views)
            } else {
                let leftHandView = subviews[index-1]
                views["LHV"] = leftHandView
                constraintsArray += NSLayoutConstraint.constraintsWithVisualFormat("H:[LHV]-0-[SUB]", options: [], metrics: nil, views: views)
            }
        }
        
        NSLayoutConstraint.activateConstraints(constraintsArray)
    }
}
