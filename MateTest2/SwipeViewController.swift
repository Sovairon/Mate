//
//  SwipeViewController.swift
//  MateTest2
//
//  Created by Eren Atas on 09/06/2017.
//  Copyright © 2017 Eren Atas. All rights reserved.
//

//
//  ViewController.swift
//  Koloda
//
//  Created by Eugene Andreyev on 4/23/15.
//  Copyright (c) 2015 Eugene Andreyev. All rights reserved.
//

import UIKit
import Firebase
import MDCSwipeToChoose

class SwipeViewController: UIViewController, MDCSwipeToChooseDelegate {
    
    @IBOutlet var TestLabel: UILabel!
    
    var people:[Person] = []
    let ChoosePersonButtonHorizontalPadding:CGFloat = 80.0
    let ChoosePersonButtonVerticalPadding:CGFloat = 20.0
    var currentPerson:Person!
    var frontCardView:ChoosePersonView!
    var backCardView:ChoosePersonView!
    let horizontalPadding:CGFloat = 20.0
    let topPadding:CGFloat = 60.0
    let bottomPadding:CGFloat = 200.0
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.people = defaultPeople()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.people = defaultPeople()
        // Here you can init your properties
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let options = MDCSwipeToChooseViewOptions()
//        options.delegate = self
//        options.likedText = "Yes"
//        options.likedColor = UIColor.blue
//        options.nopeText = "No"
//        options.nopeColor = UIColor.red
//        options.onPan = { state -> Void in
//            if state?.thresholdRatio == 0.5 && state?.direction == .left {
//                print("Photo deleted!")
//            }
//            if state?.thresholdRatio == 0.5 && state?.direction == .right {
//                print("Photo Added!")
//            }
//        }
        
        //let view = MDCSwipeToChooseView(frame: CGRect(x: self.view.bounds.midX - self.view.frame.width/4, y: self.view.bounds.midY, width: self.view.frame.width*0.5, height: self.view.frame.width*0.5), options: options)
//        let view = MDCSwipeToChooseView(frame: CGRect(x: self.view.bounds.midX - self.view.frame.width * 0.35, y: self.view.bounds.midY - self.view.frame.height * 0.35, width: self.view.frame.width * 0.7, height: self.view.frame.height * 0.5), options: options)
//        view?.imageView.image = UIImage(named: "Card_like_2")
//        self.view.addSubview(view!)
//        
//        let view2 = MDCSwipeToChooseView(frame: CGRect(x: self.view.bounds.midX - self.view.frame.width * 0.35, y: self.view.bounds.midY - self.view.frame.height * 0.35, width: self.view.frame.width * 0.7, height: self.view.frame.height * 0.5), options: options)
//        view2?.imageView.image = UIImage(named: "Card_like_1")
//        self.view.insertSubview(view2!, belowSubview: view!)
        
        self.setMyFrontCardView(frontCardView: popPersonViewWithFrame(frame: CGRect(x: horizontalPadding, y: topPadding, width: self.view.frame.width - (horizontalPadding * 2), height: self.view.frame.height - bottomPadding))!)
        self.view.addSubview(self.frontCardView)
        
        self.backCardView = self.popPersonViewWithFrame(frame: CGRect(x: horizontalPadding, y: topPadding, width: self.view.frame.width - (horizontalPadding * 2), height: self.view.frame.height - bottomPadding))
        self.view.insertSubview(self.backCardView, belowSubview: self.frontCardView)

    }
    
    // This is called when a user didn't fully swipe left or right.
    func viewDidCancelSwipe(_ view: UIView) -> Void{
        print("Couldn't decide, huh?")
    }
    
    // Sent before a choice is made. Cancel the choice by returning `false`. Otherwise return `true`.
    func view(_ view: UIView, shouldBeChosenWith: MDCSwipeDirection) -> Bool {
        if shouldBeChosenWith == .left || shouldBeChosenWith == .right {
            return true
        }
        else {
            // Snap the view back and cancel the choice.
            UIView.animate(withDuration: 0.16, animations: { () -> Void in
                view.transform = CGAffineTransform.identity
                view.center = view.superview!.center
            })
            return false
        }
        
        
    }
    
    // This is called when a user swipes the view fully left or right.
    
    
    func view(_ view: UIView, wasChosenWith wasChosenWithDirection: MDCSwipeDirection) -> Void{
        
        
        // MDCSwipeToChooseView shows "NOPE" on swipes to the left,
        // and "LIKED" on swipes to the right.
        if(wasChosenWithDirection == MDCSwipeDirection.left){
            print("You noped")
            TestLabel.text = "Nope!"
        }
        else{
            print("You liked")
            TestLabel.text = "Liked!"
        }
        
        // MDCSwipeToChooseView removes the view from the view hierarchy
        // after it is swiped (this behavior can be customized via the
        // MDCSwipeOptions class). Since the front card view is gone, we
        // move the back card to the front, and create a new back card.
        
        if(self.backCardView != nil){
            self.setMyFrontCardView(frontCardView: self.backCardView)
        }
        
        backCardView = self.popPersonViewWithFrame(frame: CGRect(x: horizontalPadding, y: topPadding, width: self.view.frame.width - (horizontalPadding * 2), height: self.view.frame.height - bottomPadding))
        //if(true){
        // Fade the back card into view.
        if(backCardView != nil){
            self.backCardView.alpha = 0.0
            self.view.insertSubview(self.backCardView, belowSubview: self.frontCardView)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                self.backCardView.alpha = 1.0
            },completion:nil)
        }
        
        // MDCSwipeToChooseView removes the view from the view hierarchy
        // after it is swiped (this behavior can be customized via the
        // MDCSwipeOptions class). Since the front card view is gone, we
        // move the back card to the front, and create a new back card.
    }
    
    func setMyFrontCardView(frontCardView:ChoosePersonView) -> Void{
        
        // Keep track of the person currently being chosen.
        // Quick and dirty, just for the purposes of this sample app.
        self.frontCardView = frontCardView
        self.currentPerson = frontCardView.person
    }
    
    func popPersonViewWithFrame(frame: CGRect) -> ChoosePersonView?{
        if(self.people.count == 0){
            return nil;
        }
        
        // UIView+MDCSwipeToChoose and MDCSwipeToChooseView are heavily customizable.
        // Each take an "options" argument. Here, we specify the view controller as
        // a delegate, and provide a custom callback that moves the back card view
        // based on how far the user has panned the front card view.
        let options:MDCSwipeToChooseViewOptions = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.threshold = 160.0
        options.onPan = { state -> Void in
            if(self.backCardView != nil){
                let frame:CGRect = frontCardViewFrame()
                self.backCardView.frame = CGRect(x: frame.origin.x, y: frame.origin.y-((state?.thresholdRatio)! * 10.0), width: frame.width, height: frame.height)

            }
        }
        
        func frontCardViewFrame() -> CGRect{
            let horizontalPadding:CGFloat = 20.0
            let topPadding:CGFloat = 60.0
            let bottomPadding:CGFloat = 200.0
            return CGRect(x: horizontalPadding, y: topPadding, width: self.view.frame.width - (horizontalPadding * 2), height: self.view.frame.height - bottomPadding)
        }
        
        func backCardViewFrame() ->CGRect{
            let frontFrame:CGRect = frontCardViewFrame()
            return CGRect(x: frontFrame.origin.x, y: frontFrame.origin.y + 10.0, width: frontFrame.width, height: frontFrame.height)
        }
        
        // Create a personView with the top person in the people array, then pop
        // that person off the stack.
        
        let personView:ChoosePersonView = ChoosePersonView(frame: frame, person: self.people[0], options: options)
        self.people.remove(at: 0)
        return personView
        
    }
    
    
    
    func defaultPeople() -> [Person]{
        // It would be trivial to download these from a web service
        // as needed, but for the purposes of this sample app we'll
        // simply store them in memory.
        return [Person(name: "Finn", image: UIImage(named: "Card_like_1"), age: 2, sharedFriends: 3, breed: "Bulldog", photos: 5), Person(name: "Jake", image: UIImage(named: "Card_like_2"), age: 3, sharedFriends: 3, breed: "Pug", photos: 5), Person(name: "Fiona", image: UIImage(named: "Card_like_1"), age: 7, sharedFriends: 3, breed: "Terrier", photos: 5), Person(name: "P.Gumball", image: UIImage(named: "Card_like_2"), age: 4, sharedFriends: 3, breed: "Golden", photos: 5)]
        
    }
    
    func nopeButton(){
        self.frontCardView.mdc_swipe(MDCSwipeDirection.left)
    }
    
    func likeButton(){
        self.frontCardView.mdc_swipe(MDCSwipeDirection.right)
    }
    
    @IBAction func NoButton(_ sender: Any) {
        nopeButton()
    }
    
    @IBAction func YesButton(_ sender: Any) {
        likeButton()
    }
    
}
