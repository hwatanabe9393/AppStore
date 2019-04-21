//
//  ReviewsController.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/12/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class ReviewsController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout{
    
    let cellId = "cellId"
    var reviews: Reviews?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.backgroundColor = .white
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 48, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews?.feed.entry.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ReviewCell
        let entry = reviews?.feed.entry[indexPath.item]
        cell.titleLabel.text = entry?.title.label
        cell.authorLabel.text = entry?.author.name.label
        cell.bodyLabel.text = entry?.content.label
        for (index, view) in cell.starsStackView.arrangedSubviews.enumerated(){
            view.alpha = (Int(entry?.rating.label ?? "0") ?? 0) > index ? 1 : 0
        }
        return cell
    }
}
