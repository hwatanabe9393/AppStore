//
//  AppDetailController.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/3/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    //Dependency
    fileprivate let appId: String
    
    //dependency injection constructor
    init(appId: String){
        self.appId = appId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var app: Result?{
        didSet{
            DispatchQueue.main.async {[weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    var reviews: Reviews?{
        didSet{
            DispatchQueue.main.async {[weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    let detailCellId = "appDetailCell"
    let previewCellId = "previewCellId"
    let reviewCellId = "reviewCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellId)
        
        fetchData()
    }
    
    fileprivate func fetchData(){
        let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
        Service.shared.fetchGenericJASONData(urlString: urlString) {[weak self] (searchResult: SearchResult?, error) in
            guard error == nil else{
                print("Error: \(error!)")
                return
            }
            
            guard let searchResult = searchResult else{
                print("Result is empty for appid: \(self?.appId ?? "N/A")")
                return
            }
            self?.app = searchResult.results.first
        }
        
        let reviewUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&cc=US"
        Service.shared.fetchGenericJASONData(urlString: reviewUrl) {[weak self] (reviews: Reviews?, err) in
            if let err = err{
                print("Failed to decode reviews: ", err)
                return
            }
            self?.reviews = reviews
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        if indexPath.item == 0{
            // calculate the necessary size for our cell somehow
            let size = CGSize(width: view.frame.width, height: .greatestFiniteMagnitude)
            let dummyCell = AppDetailCell(frame: CGRect(origin: .zero, size: size))
            dummyCell.app = app
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(size)
            height = estimatedSize.height
        }else if indexPath.item == 1{
            height = 500
        }else{
            height = 250
        }
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
            cell.app = app
            return cell
        }else if indexPath.item == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            cell.horizontalController.app = app
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewRowCell
            cell.reviewsController.reviews = self.reviews
            return cell
        }
    }
}
