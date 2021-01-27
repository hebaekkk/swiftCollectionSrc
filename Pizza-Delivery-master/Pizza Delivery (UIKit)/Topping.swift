//
//  Topping.swift
//  Pizza Delivery (UIKit)
//
//  Created by Justin Chester on 2019-11-29.
//  Copyright © 2019 Justin Chester. All rights reserved.
//

import Foundation

class Topping : Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(description)
        hasher.combine(price)
        hasher.combine(calories)
    }
    
    static func == (lhs: Topping, rhs: Topping) -> Bool {
        return (lhs.name == rhs.name && lhs.description == rhs.description && lhs.price == rhs.price && lhs.calories == rhs.calories)
    }
    
    var name: String
    var description: String
    var price: Double
    var calories: Int
    
    init(_name: String, _description: String, _price: Double, _calories: Int) {
        name = _name
        description = _description
        price = _price
        calories = _calories
    }
}
