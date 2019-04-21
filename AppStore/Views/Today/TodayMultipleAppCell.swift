//
//  TodayMultipleAppCell.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/17/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
    override var todayItem: TodayItem!{
        didSet{
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
        }
    }
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)
    
    let multipleAppsController = UIViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        multipleAppsController.view.backgroundColor = .black
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel,
            titleLabel,
            multipleAppsController.view
            ], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
