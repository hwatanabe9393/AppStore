//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 3/21/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    var result: Result! {
        didSet{
            nameLabel.text = result.trackName
            categoryLabel.text = result.primaryGenreName
            ratingLabel.text = result.averageUserRating != nil ? "Rating: \(result.averageUserRating!)" : "Rating: N/A"
            let url = URL(string: result.artworkUrl100)
            iconImageView.sd_setImage(with: url)
            
            screenshot1ImageView.sd_setImage(with: URL(string: result.screenshotUrls[0]))
            if result.screenshotUrls.count > 1{
                screenshot2ImageView.sd_setImage(with: URL(string: result.screenshotUrls[1]))
            }
            
            if result.screenshotUrls.count > 2{
                screenshot3ImageView.sd_setImage(with: URL(string: result.screenshotUrls[2]))
            }
        }
    }
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAME"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Rating: N/A"
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = .lightGray
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var screenshot1ImageView = self.createScreenshotImageView()
    lazy var screenshot2ImageView = self.createScreenshotImageView()
    lazy var screenshot3ImageView = self.createScreenshotImageView()
    
    func createScreenshotImageView()->UIImageView{
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 1.0).cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 
        let infoStackView = UIStackView(arrangedSubviews: [iconImageView, VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingLabel]), getButton])
        infoStackView.spacing = 12
        infoStackView.alignment = .center
        
        let screenshotsStackView = UIStackView(arrangedSubviews: [screenshot1ImageView, screenshot2ImageView, screenshot3ImageView])
        screenshotsStackView.spacing = 12
        screenshotsStackView.distribution = .fillEqually
        
        let appStackView = VerticalStackView(arrangedSubviews: [infoStackView, screenshotsStackView], spacing: 16)
        
        addSubview(appStackView)
        appStackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
