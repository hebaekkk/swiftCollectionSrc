//
//  ViewController.swift
//  Pizza Delivery (UIKit)
//
//  Created by Justin Chester on 2019-11-19.
//  Copyright © 2019 Justin Chester. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var CustomizeButtonOutlet: UIButton!
    @IBAction func CustomizeButton(_ sender: UIButton) {
        print("Customize")
    }
    @IBOutlet weak var MenuButtonOutlet: UIButton!
    @IBAction func MenuButton(_ sender: UIButton) {
        print("Menu")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            get {
                return .portrait
            }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        CustomizeButtonOutlet.layer.cornerRadius = 10
        CustomizeButtonOutlet.layer.borderWidth = 2
        CustomizeButtonOutlet.layer.borderColor = UIColor.white.cgColor
        
        MenuButtonOutlet.layer.cornerRadius = 10
        MenuButtonOutlet.layer.borderWidth = 2
        MenuButtonOutlet.layer.borderColor = UIColor.white.cgColor
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

