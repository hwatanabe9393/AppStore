//
//  TodayCell.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/14/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class TodayCell: BaseTodayCell {
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 28))
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 16), numberOfLines: 3)
    override var todayItem: TodayItem!{
        didSet{
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            imageView.image = todayItem.image
            descriptionLabel.text = todayItem.description
            backgroundColor = todayItem.backgrounColor
        }
    }
    
    var topConstraint: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        backgroundColor = .white
        layer.cornerRadius = 16
        
        imageView.contentMode = .scaleAspectFill
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        imageView.centerInSuperview(size: CGSize(width: 240, height: 240))
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [categoryLabel, titleLabel, imageContainerView, descriptionLabel], spacing: 8)
        addSubview(verticalStackView)
        verticalStackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24))
        topConstraint = verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        topConstraint.isActive = true
        //verticalStackView.fillSuperview(padding: UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
