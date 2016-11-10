//
//  FourthViewController.swift
//  ScrollView-AutoLayout
//
//  Created by Oliver Toscan on 08/12/15.
//  Copyright © 2015 Luna Square. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    let colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.yellow, UIColor.orange]
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
        scrollView.isPagingEnabled = true
        dummyView.addSubview(scrollView)
        
        // Container
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.purple
        scrollView.addSubview(container)
        
        
        var constraints: [NSLayoutConstraint] = []
        let views = ["D":dummyView, "S":scrollView, "C":container]
        
        // Dummy Constraints
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[D]-0-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[D(150)]", options: [], metrics: nil, views: views)

        // ScrollView Contraints
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[S]-0-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[S]-0-|", options: [], metrics: nil, views: views)

        // Container Constraints
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[C]-0-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[C(==D)]-0-|", options: [], metrics: nil, views: views)

        constraints += [NSLayoutConstraint(item: dummyView, attribute: .width, relatedBy: .equal,
                                          toItem: container, attribute: .width, multiplier: 1/CGFloat(colors.count), constant: 0)]

        NSLayoutConstraint.activate(constraints)
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
            
            constraintsArray += NSLayoutConstraint.constraints(withVisualFormat: "H:[SUB(==D)]", options: [], metrics: nil, views: views)
            constraintsArray += NSLayoutConstraint.constraints(withVisualFormat: "V:[SUB(==D)]", options: [], metrics: nil, views: views)
            constraintsArray += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[SUB]", options: [], metrics: nil, views: views)
            
            if index == 0 {
                constraintsArray += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[SUB]", options: [], metrics: nil, views: views)
            } else {
                let leftHandView = subviews[index-1]
                views["LHV"] = leftHandView
                constraintsArray += NSLayoutConstraint.constraints(withVisualFormat: "H:[LHV]-0-[SUB]", options: [], metrics: nil, views: views)
            }
        }
        
        NSLayoutConstraint.activate(constraintsArray)
    }
}
