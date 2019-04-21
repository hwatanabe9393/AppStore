//
//  AppsHeaderCell.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 3/27/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    let companyLabel = UILabel(text: "Facebook", font: UIFont.boldSystemFont(ofSize: 12))
    let titleLabel = UILabel(text: "Keeping up with friends is faster than ever", font: UIFont.systemFont(ofSize: 24))
    let imageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        companyLabel.textColor = .blue
        titleLabel.numberOfLines = 2
        
        let stackView = VerticalStackView(arrangedSubviews: [
            companyLabel,titleLabel, imageView
            ], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
