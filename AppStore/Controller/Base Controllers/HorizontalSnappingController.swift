//
//  HorizontalSnappingController.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/2/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {
    init(){
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//
//class SnappingLayout: UICollectionViewFlowLayout{
//
//    //From: https://stackoverflow.com/questions/33855945/uicollectionview-snap-onto-cell-when-scrolling-horizontally/33856774
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
//        let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
//
//        let itemWidth = collectionView.frame.width - 32
//        let itemSpace = itemWidth + minimumInteritemSpacing
//        var currentItemIdx = round(collectionView.contentOffset.x / itemSpace)
//
//        // Skip to the next cell, if there is residual scrolling velocity left.
//        // This helps to prevent glitches
//        let vX = velocity.x
//        if vX > 0 {
//            currentItemIdx += 1
//        } else if vX < 0 {
//            currentItemIdx -= 1
//        }
//
//        let nearestPageOffset = currentItemIdx * itemSpace
//        return CGPoint(x: nearestPageOffset,
//                       y: parent.y)
//    }
//}
