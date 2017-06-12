//
//  Person.swift
//  MateTest2
//
//  Created by Eren Atas on 13/06/2017.
//  Copyright © 2017 Eren Atas. All rights reserved.
//

import Foundation

class Person: NSObject {
    
    
    let Name: NSString
    let Image: UIImage!
    let Age: NSNumber
    let NumberOfSharedFriends: NSNumber?
    let BreedType: NSString
    let NumberOfPhotos: NSNumber
    
    override var description: String {
        return "Name: \(Name), \n Image: \(Image), Age: \(Age), NumberOfSharedFriends: \(String(describing: NumberOfSharedFriends)), BreedType: \(BreedType), NumberOfPhotos: \(NumberOfPhotos)"
    }
    
    init(name: NSString?, image: UIImage?, age: NSNumber?, sharedFriends: NSNumber?, breed: NSString?, photos: NSNumber?){
        self.Name = name ?? ""
        self.Image = image
        self.Age = age ?? 0
        self.NumberOfSharedFriends = sharedFriends ?? 0
        self.BreedType = breed ?? ""
        self.NumberOfPhotos = photos ?? 0
    }
    
}
