//
//  Catogery.swift
//  Todoey
//
//  Created by user142012 on 10/14/18.
//  Copyright © 2018 user142012. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
