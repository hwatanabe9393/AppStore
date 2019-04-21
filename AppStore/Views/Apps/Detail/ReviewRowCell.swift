//
//  ReviewRowCell.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/12/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    let reviewsController = ReviewsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .purple
        addSubview(reviewsController.view)
        reviewsController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
