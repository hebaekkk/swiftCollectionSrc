//
//  ViewController.swift
//  CustomXibView
//
//  Created by Kang Seongchan on 2020/08/04.
//  Copyright © 2020 Hanryang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sub: UIView!
    lazy var customView = CustomView(frame: CGRect(x: sub.frame.minX, y: sub.frame.minY, width: sub.frame.width, height: sub.frame.height))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel : xibViewModel = xibViewModel(profileImageName: "membership", businessName: "베리베리깨끗해요", userName: "호로롤", businessNum: "123-123123-123", membership: "SUPER")
        
        
        
        customView.configure(with: viewModel)
        customView.backgroundColor = .cyan
        self.view.addSubview(customView)
        //self.sub.addSubview(customView)
        customView.leadingAnchor.constraint(equalTo: sub.leadingAnchor).isActive = true
        customView.topAnchor.constraint(equalTo: sub.topAnchor).isActive = true
        customView.trailingAnchor.constraint(equalTo: sub.trailingAnchor).isActive = true
        customView.bottomAnchor.constraint(equalTo: sub.bottomAnchor).isActive = true

    }


}

