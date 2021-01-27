//
//  Pizza.swift
//  Pizza Delivery (UIKit)
//
//  Created by Justin Chester on 2019-11-20.
//  Copyright © 2019 Justin Chester. All rights reserved.
//

import UIKit

class Pizza: NSObject {
    
    enum Crusts: CaseIterable{
        case original
        case thin
        case glutenFree
        
        func AsString() -> String {
            switch self {
            case .original:
                return "Original"
            case .thin:
                return "Thin"
            case .glutenFree:
                return "Gluten Free"
            }
        }
    }
    
    enum Cheeses: CaseIterable {
        case threeCheeseBlend
        case mozzarella
        case parmesan
        
        func AsString() -> String {
            switch self {
            case .mozzarella:
                return "Mozzarella"
            case .parmesan:
                return "Parmesan"
            case .threeCheeseBlend:
                return "Three Cheese Blend"
            }
        }
    }
    
    
    static let AllToppings: [Topping] = [
        Topping(_name: "Pepperoni", _description: "Delicious pepperoni", _price: 1.25, _calories: 100),
        Topping(_name: "Chicken", _description: "Grilled chicken", _price: 1.25, _calories: 100),
        Topping(_name: "Sausage", _description: "Savoury sausage", _price: 1.25, _calories: 150),
        Topping(_name: "Salami", _description: "Little a salami", _price: 1.25, _calories: 100),
        Topping(_name: "Bacon", _description: "Fresh bacon", _price: 1.25, _calories: 200),
        Topping(_name: "Beef", _description: "Hearty beef", _price: 1.25, _calories: 100),
        Topping(_name: "Ham", _description: "Juicy ham", _price: 1.25, _calories: 150),
        Topping(_name: "Green Pepper", _description: "Fresh cut green pepper", _price: 1.00, _calories: 25),
        Topping(_name: "Mushroom", _description: "Fresh locally sourced mushrooms", _price: 1.00, _calories: 25),
        Topping(_name: "Onion", _description: "Tasty sliced onion", _price: 1.00, _calories: 25),
        Topping(_name: "Spinach", _description: "Crisp baby spinach", _price: 1.00, _calories: 10),
        Topping(_name: "Tomato", _description: "Juicy sliced tomatos", _price: 1.00, _calories: 40)
    ]
    
    static func getToppingInfo(name: String) -> Topping {
        return Pizza.AllToppings.first(where: {$0.name == name})!
    }
    
    func addTopping(_ name: String) {
        toppings.append(Pizza.getToppingInfo(name: name));
    }
    
    func addTopping(_ topping: Topping) {
        toppings.append(topping);
    }

    var numberOfToppings: Int
    var crustType: Crusts
    var cheeseType: Cheeses
    var toppings: [Topping]
    
    init(_crustType: Crusts = .original, _cheeseType: Cheeses = .mozzarella, _toppings: [Topping] = []) {
        crustType = _crustType
        cheeseType = _cheeseType
        toppings = _toppings
        numberOfToppings = Pizza.AllToppings.count
    }
    
    func PrintPizza() {
        print("Crust: \(crustType.AsString())")
        print("Cheese: \(cheeseType.AsString())")
        print("Toppings: ")
        for topping in toppings {
            print("\t\(topping.name)")
        }
    }
}
