//
//  CustomizeViewController.swift
//  Pizza Delivery (UIKit)
//
//  Created by Justin Chester on 2019-11-26.
//  Copyright © 2019 Justin Chester. All rights reserved.
//

import UIKit

class CustomizeViewController: UIViewController, UITableViewDataSource, ToppingCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var PizzaBuilderImage: UIImageView!
    @IBOutlet weak var ContinueButtonOutlet: UIButton!
    @IBOutlet weak var toppingQuantityStepperOutlet: UIStepper!
    @IBAction func ContinueButtonAction(_ sender: UIButton) {
        
    }
    
    var AllToppings = Pizza.AllToppings
    var userPizza = Pizza()
    var addedToppingImages: [String : UIImageView] = [:]
    
    override func viewWillAppear(_ animated: Bool) {
        let greenColorCode = 0x69834d
        //let beigeColorCode = 0xf2e9de
        let greenColor = UIColor(rgb: greenColorCode)
        self.view.backgroundColor = greenColor
        formatTableView()
        formatContinueButton()
        initializePizzaImage()
    }
    
    func formatTableView() {
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView?.backgroundColor = UIColor.clear
        tableView.layer.borderWidth = 2.0
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.layer.cornerRadius = 5
    }
    
    func formatContinueButton() {
        ContinueButtonOutlet.layer.cornerRadius = 10
        ContinueButtonOutlet.layer.borderWidth = 2
        ContinueButtonOutlet.layer.borderColor = UIColor.white.cgColor
    }
    
    func initializePizzaImage() {
        let basePizzaImage = UIImage(named: "Pizza Builder/basepizza")
        let basePizzaImageView: UIImageView = UIImageView()
        let frame = PizzaBuilderImage.frame
        
        basePizzaImageView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height)
        basePizzaImageView.image = basePizzaImage
        
        self.view.addSubview(basePizzaImageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllToppings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toppingCell") as! toppingTableViewCell
                    
        cell.toppingLabel.text = AllToppings[indexPath.row].name
        cell.priceLabel.text = String(format: "$%.2f",AllToppings[indexPath.row].price)
        cell.caloriesLabel.text = "\(AllToppings[indexPath.row].calories) cals"
        cell.descriptionTextView.text = AllToppings[indexPath.row].description
        
        cell.toppingImage.image = UIImage(named: "Toppings/\(AllToppings[indexPath.row].name)")
        
        cell.delegate = self
        
        return cell //4.
    }
    
    func quantityStepperTapped(cell: toppingTableViewCell) {
        if let toppingName = cell.toppingLabel.text {
            if (cell.toppingQuantityStepperOutlet.value > 0) {
                addTopping(toppingName)
            }
            else {
                removeTopping(toppingName)
            }
        }
    }
    
    func addTopping(_ name: String) {
        let toppingFromName = Pizza.getToppingInfo(name: name);
        if (userPizza.toppings.contains(toppingFromName)) {
            return
        }
        userPizza.addTopping(name)
        addImageToPizzaBuilder(imageName: name)
    }
    
    func removeTopping(_ name: String) {
        let toppingFromName = Pizza.getToppingInfo(name: name);
        //If this is reached, the topping should always exist in the toppings array
        userPizza.toppings.remove(at: userPizza.toppings.firstIndex(of: toppingFromName)!)
        addedToppingImages[name]?.removeFromSuperview()
    }
    
    func addImageToPizzaBuilder(imageName: String) {
        let toppingImage = UIImage(named: "Pizza Builder/\(imageName)")
        let toppingImageView: UIImageView = UIImageView()
        let frame = PizzaBuilderImage.frame
       
        toppingImageView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height)
        toppingImageView.image = toppingImage
       
        addedToppingImages[imageName] = toppingImageView
        self.view.addSubview(toppingImageView)
    }
}
