//
//  AppsHorizontalController.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 3/26/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class AppsHorizontalController: BaseListController, UICollectionViewDelegateFlowLayout {
    let cellId = "AppRowCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .blue
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
        }
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
        return UIEdgeInsets(top: topBottomPadding, left: 16, bottom: topBottomPadding, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    //MARK:- UICollectionViewDatasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
}
