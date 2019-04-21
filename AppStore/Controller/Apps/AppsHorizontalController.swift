//
//  AppsHorizontalController.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 3/26/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    let cellId = "AppRowCell"
    var didSelectHandler: ((FeedResult) -> ())?
    
    var appGroup: AppGroup? {
        didSet{
            DispatchQueue.main.async {[weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout
    let topBottomPadding: CGFloat = 12
    let leftRightPaddning: CGFloat = 16
    let lineSpacing: CGFloat = 10
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - topBottomPadding * 2 - lineSpacing * 2)/3
        let width = view.frame.width - leftRightPaddning * 2
        return CGSize(width:  width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let feedResult = appGroup?.feed.results[indexPath.item]{
            didSelectHandler?(feedResult)
        }
    }
    
    //MARK:- UICollectionViewDatasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppRowCell
        if let feedResult = appGroup?.feed.results[indexPath.item] {
            cell.nameLabel.text = feedResult.name
            cell.companyLabel.text = feedResult.artistName
            cell.imageView.sd_setImage(with: URL(string: feedResult.artworkUrl100), completed: nil)
        }
        return cell
    }
}
