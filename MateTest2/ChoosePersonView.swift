//
//  ChoosePersonView.swift
//  MateTest2
//
//  Created by Eren Atas on 13/06/2017.
//  Copyright © 2017 Eren Atas. All rights reserved.
//

import UIKit
import MDCSwipeToChoose

class ChoosePersonView: MDCSwipeToChooseView {
    let ChoosePersonViewImageLabelWidth:CGFloat = 42.0;
    var person: Person!
    var informationView: UIView!
    var nameLabel: UILabel!
    
    init(frame: CGRect, person: Person, options: MDCSwipeToChooseViewOptions) {
        
        super.init(frame: frame, options: options)
        self.person = person
        
        if let image = self.person.Image {
            self.imageView.image = image
        }
        
        self.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        //UIViewAutoresizing.flexibleBottomMargin
        
        self.imageView.autoresizingMask = self.autoresizingMask
        constructInformationView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func constructInformationView() -> Void{
        let bottomHeight:CGFloat = 60.0
        let bottomFrame:CGRect =   CGRect(x: 0,
                                          y: self.bounds.height - bottomHeight,
                                          width: self.bounds.width,
                                          height: bottomHeight);
        self.informationView = UIView(frame:bottomFrame)
        self.informationView.backgroundColor = UIColor.white
        self.informationView.clipsToBounds = true
        self.informationView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleTopMargin]
        self.addSubview(self.informationView)
        constructNameLabel()
    }
    
    func constructNameLabel() -> Void{
        let leftPadding:CGFloat = 12.0
        let topPadding:CGFloat = 17.0
        let frame:CGRect = CGRect(x: leftPadding,
                                  y: topPadding,
                                  width: floor(self.informationView.frame.width/2),
                                  height: self.informationView.frame.height - topPadding)
        self.nameLabel = UILabel(frame:frame)
        self.nameLabel.text = "\(person.Name), \(person.Age)"
        self.informationView .addSubview(self.nameLabel)
    }

}

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}
