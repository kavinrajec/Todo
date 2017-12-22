//
//  Category.swift
//  Todo
//
//  Created by Kavin HS on 22/12/17.
//  Copyright © 2017 Kavin. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
