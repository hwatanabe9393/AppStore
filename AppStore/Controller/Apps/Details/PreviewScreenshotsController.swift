//
//  PreviewScreenshotsController.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/12/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class PreviewScreenshotsController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    var app: Result?{
        didSet{
            collectionView.reloadData()
        }
    }
    class ScreenShotCell: UICollectionViewCell {
        let imageView = UIImageView(cornerRadius: 12)
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(imageView)
            imageView.fillSuperview()
            imageView.backgroundColor = .white
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(ScreenShotCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenShotCell
        if let app = app{
            cell.imageView.sd_setImage(with: URL(string: app.screenshotUrls[indexPath.item]))
        }
        return cell
    }
}
