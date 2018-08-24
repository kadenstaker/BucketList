//
//  BucketListItem.swift
//  Bucketlist
//
//  Created by Kaden Staker on 8/23/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import Foundation

class BucketListItem: Equatable, Codable {
    
    var title: String
    var age: Int
    var description: String
    
    init(title: String, age: Int, description: String) {
        self.title = title
        self.age = age
        self.description = description
    }
    
    // Equatable portion, make sure to remember to return a Boolean
    static func ==(lhs: BucketListItem, rhs: BucketListItem) -> Bool {
        if lhs.title != rhs.title {return false}
        if lhs.age != rhs.age {return false}
        if lhs.description != rhs.description {return false} 
        return true
    }
    
    
}
