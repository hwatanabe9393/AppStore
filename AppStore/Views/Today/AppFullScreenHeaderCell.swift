//
//  AppFullScreenHeaderCell.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/14/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class AppFullScreenHeaderCell: UITableViewCell {
    let todayCell = TodayCell()
    let closeButton: UIButton = {
       let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(todayCell)
        todayCell.fillSuperview()
        
        addSubview(closeButton)
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 12), size: CGSize(width: 80, height: 38))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
