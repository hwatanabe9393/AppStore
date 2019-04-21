//
//  ReviewCell.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/12/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 16))
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    let starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach({ (_) in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubviews.append(imageView)
        })
        arrangedSubviews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()
    let bodyLabel = UILabel(text: "Review body\nReview body\nReview body\nReview body", font: .systemFont(ofSize: 18), numberOfLines: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.35)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                titleLabel, authorLabel
                ], customSpacing: 8),
            starsStackView,
            bodyLabel
            ], spacing: 12)
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        authorLabel.textAlignment = .right
        
        addSubview(stackView)
        //stackView.fillSuperview(padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
