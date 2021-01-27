//
//  CustomView.swift
//  CustomXibView
//
//  Created by Kang Seongchan on 2020/08/04.
//  Copyright © 2020 Hanryang. All rights reserved.
//

import UIKit

struct xibViewModel {
    let profileImageName: String
    
    let businessName: String
    let userName: String
    let businessNum: String
    let membership: String
}

class CustomView: XibView {
    
}

class XibView: UIView {
    
    private var viewModel: xibViewModel?
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var businessNumLabel: UILabel!
    @IBOutlet weak var membershipLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let className = String(describing: type(of: self))
        let nib = UINib(nibName: className, bundle: Bundle.main)
        
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
        
        
        
    }
    
    init(with viewModel: xibViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        
        configure(with: viewModel)
    }
    
    func configure(with viewModel: xibViewModel) {
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.backgroundColor = .yellow
        
        profileImage.image = UIImage(named: viewModel.profileImageName)
        
        businessNameLabel.text = viewModel.businessName
        userNameLabel.text = viewModel.userName
        businessNumLabel.text = viewModel.businessNum
        membershipLabel.text = viewModel.membership
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


