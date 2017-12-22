//
//  Item.swift
//  Todo
//
//  Created by Kavin HS on 22/12/17.
//  Copyright © 2017 Kavin. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object  {
    @objc dynamic var title: String = ""
    @objc dynamic var isSelected: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
