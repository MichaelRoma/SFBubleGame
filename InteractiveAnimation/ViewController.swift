//
//  ViewController.swift
//  CALayer
//
//  Created by Mykhailo Romanovskyi on 09.02.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var someView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var skyBlueView: UIView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var orangeView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let someViewPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragSomeView))
        let blueViewPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragblueView))
        let skyBlueViewPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragskyBlueView))
        let redViewPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragredView))
        let orangeViewPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragorangeView))
        
        someView.addGestureRecognizer(someViewPanGestureRecognizer)
        blueView.addGestureRecognizer(blueViewPanGestureRecognizer)
        skyBlueView.addGestureRecognizer(skyBlueViewPanGestureRecognizer)
        redView.addGestureRecognizer(redViewPanGestureRecognizer)
        orangeView.addGestureRecognizer(orangeViewPanGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        someView.layer.cornerRadius = someView.bounds.width / 2
        blueView.layer.cornerRadius = blueView.bounds.width / 2
        skyBlueView.layer.cornerRadius = skyBlueView.bounds.width / 2
        redView.layer.cornerRadius = redView.bounds.width / 2
        orangeView.layer.cornerRadius = orangeView.bounds.width / 2
    }
    
    
    @objc func dragSomeView(recognizer: UIPanGestureRecognizer) {
        dragAction(recognizer: recognizer, dragView: someView)
    }
    
    @objc func dragblueView(recognizer: UIPanGestureRecognizer) {
        dragAction(recognizer: recognizer, dragView: blueView)
    }
    
    @objc func dragskyBlueView(recognizer: UIPanGestureRecognizer) {
        dragAction(recognizer: recognizer, dragView: skyBlueView)
    }
    
    @objc func dragredView(recognizer: UIPanGestureRecognizer) {
        dragAction(recognizer: recognizer, dragView: redView)
    }
    
    @objc func dragorangeView(recognizer: UIPanGestureRecognizer) {
        dragAction(recognizer: recognizer, dragView: orangeView)
    }
    
    private func dragAction(recognizer: UIPanGestureRecognizer, dragView: UIView) {
        let state = recognizer.state
        if state == .changed {
            let translation = recognizer.translation(in: self.view)
            let newX = dragView.center.x + translation.x
            let newY = dragView.center.y + translation.y
            dragView.center = CGPoint(x: newX, y: newY)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        if state == .ended {
            switch true {
            case someView.frame.contains(dragView.center) where dragView != someView:
                myAnitaion(dragView: dragView, contactedView: someView)
            case blueView.frame.contains(dragView.center) where dragView != blueView:
                myAnitaion(dragView: dragView, contactedView: blueView)
            case skyBlueView.frame.contains(dragView.center) where dragView != skyBlueView:
                myAnitaion(dragView: dragView, contactedView: skyBlueView)
            case redView.frame.contains(dragView.center) where dragView != redView:
                myAnitaion(dragView: dragView, contactedView: redView)
            case orangeView.frame.contains(dragView.center) where dragView != orangeView:
                myAnitaion(dragView: dragView, contactedView: orangeView)
            default:
                print("No contact")
            }
        }
    }
    
    private func myAnitaion(dragView: UIView, contactedView: UIView) {
        if dragView.bounds.width < contactedView.bounds.width {
            UIView.animateKeyframes(withDuration: 2,
                                    delay: 0,
                                    options: .calculationModeCubic) {
                UIView.addKeyframe(withRelativeStartTime: 0,
                                   relativeDuration: 0.25) {
                    dragView.layer.opacity = 0.0
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5,
                                   relativeDuration: 0.25) {
                    contactedView.transform = contactedView.transform.scaledBy (x: 1.2, y: 1.2)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.75,
                                   relativeDuration: 0.25) {
                    contactedView.backgroundColor = dragView.backgroundColor
                }
            }
        }
    }
}

