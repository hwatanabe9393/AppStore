//
//  AppDetailCell.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/3/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    var app: Result?{
        didSet{
            nameLabel.text = app?.trackName
            priceButton.setTitle(app?.formattedPrice, for: .normal)
            releaseNotesLabel.text = app?.releaseNotes
            appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
        }
    }
    
    let appIconImageView = UIImageView(cornerRadius: 16)
    let nameLabel: UILabel = UILabel(text: "name", font: UIFont.boldSystemFont(ofSize: 24), numberOfLines: 2)
    let priceButton = UIButton(title: "$0.00")
    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
    let releaseNotesLabel = UILabel(text: "ReleaseNotes", font: .systemFont(ofSize: 18), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        appIconImageView.backgroundColor = .white
        appIconImageView.constrainWidth(constant: 140)
        appIconImageView.constrainHeight(constant: 140)
        
        priceButton.backgroundColor = .blue
        priceButton.constrainHeight(constant: 32)
        priceButton.constrainWidth(constant: 80)
        priceButton.layer.cornerRadius = 32/2
        priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        priceButton.setTitleColor(.white, for: .normal)
        
        let horizontalStackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            VerticalStackView(arrangedSubviews: [
                nameLabel,
                UIStackView(arrangedSubviews: [priceButton, UIView()]),
                UIView()
                ], spacing: 12)
            ], customSpacing: 20)
        
        let stackView = VerticalStackView(arrangedSubviews: [
            horizontalStackView,
            whatsNewLabel,
            releaseNotesLabel
            ], spacing: 16)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIStackView{
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0){
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
