//
//  toppingTableViewCell.swift
//  Pizza Delivery (UIKit)
//
//  Created by Justin Chester on 2019-11-26.
//  Copyright © 2019 Justin Chester. All rights reserved.
//

import UIKit


protocol ToppingCellDelegate {
    func quantityStepperTapped(cell: toppingTableViewCell)
}

class toppingTableViewCell: UITableViewCell {
    @IBOutlet weak var toppingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var toppingImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var toppingQuantityStepperOutlet: UIStepper!
    
    @IBAction func toppingQuantityStepperTapped(_ sender: UIStepper) {
        quantityLabel.text = quantityToText(Int(sender.value))
    }
    
    var delegate: ToppingCellDelegate?

    @IBAction func quantityStepperTapped(sender: AnyObject) {
        delegate?.quantityStepperTapped(cell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImage.image = UIImage(named: "toppingCellBackground")
        descriptionTextView.isEditable = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func quantityToText(_ quantity: Int) -> String {
        switch quantity{
            case 0:
                return "None"
            case 1:
                return "Regular"
            case 2:
                return "Extra"
            default:
                return ""
        }
    }
}
