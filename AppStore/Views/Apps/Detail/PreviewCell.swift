//
//  PreviewCell.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/12/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class PreviewCell: UICollectionViewCell {
    let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))
    var horizontalController = PreviewScreenshotsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(previewLabel)
        addSubview(horizontalController.view)
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        horizontalController.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
