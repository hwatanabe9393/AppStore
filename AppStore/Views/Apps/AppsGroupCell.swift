//
//  AppsGroupCell.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 3/26/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit



class AppsGroupCell: UICollectionViewCell {
    let titleLabel = UILabel(text: "App Section", font: UIFont.boldSystemFont(ofSize: 30))
    
    let horizontalController = AppsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
