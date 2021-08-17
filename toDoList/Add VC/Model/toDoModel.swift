//
//  toDoModel.swift
//  toDoList
//
//  Created by MacOS on 16/08/2021.
//

import UIKit
import RealmSwift



class toDoModel: Object {
    @objc dynamic var toDoText: String = ""
    @objc dynamic var date: String = ""

    @objc dynamic var id = Int.random(in: 0..<2147483648)
    
    override class func primaryKey() -> String? {
        return "id"
    }
        
}

