//
//  AppsController.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 3/26/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class AppsController: BaseListController, UICollectionViewDelegateFlowLayout{
    let cellId = "id"
    let headerId = "header"
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        fetchData()
    }
    
    var socialApps = [SocialApp]()
    var appGroups = [AppGroup]()
    
    fileprivate func fetchData(){
        let dispatchGroup = DispatchGroup()
        var newGamesWelove: AppGroup?
        var topGrossing: AppGroup?
        var topFree: AppGroup?
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps {[weak self] (apps, error) in
            if let error = error{
                print("Failed to fetch Social Apps: \(error)")
                dispatchGroup.leave()
                return
            }
            if let apps = apps{
                self?.socialApps = apps
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchNewGamesWeLove{(appGroup, error) in
            if let error = error{
                print("Failed to New Games We Love: \(error)")
                dispatchGroup.leave()
                return
            }
            if let appGroup = appGroup{
                newGamesWelove = appGroup
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing{(appGroup, error) in
            if let error = error{
                print("Failed to fetch Top Grossing: \(error)")
                dispatchGroup.leave()
                return
            }
            if let appGroup = appGroup{
                topGrossing = appGroup
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopFree{(appGroup, error) in
            if let error = error{
                print("Failed to fetch Top Free: \(error)")
                dispatchGroup.leave()
                return
            }
            if let appGroup = appGroup{
                topFree = appGroup
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {[weak self] in
            if let newGamesWelove = newGamesWelove{
                self?.appGroups.append(newGamesWelove)
            }
            if let topGrossing = topGrossing{
                self?.appGroups.append(topGrossing)
            }
            if let topFree = topFree{
                self?.appGroups.append(topFree)
            }
            self?.activityIndicatorView.stopAnimating()
            self?.collectionView.reloadData()
        }
    }
    
    //MARK:- UICOllectionViewDelegateFlowlayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    //MARK:- UICollectionView Delegate & Datasource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsHeader
        header.appHeaderHorizontalController.socialApps = socialApps
        header.appHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        
        let editorsChoiceGames = appGroups[indexPath.item]
        cell.titleLabel.text = editorsChoiceGames.feed.title
        cell.horizontalController.appGroup = editorsChoiceGames
        cell.horizontalController.didSelectHandler = {[weak self] (feedresult) in
            let appDetailController = AppDetailController(appId: feedresult.id)
            self?.navigationController?.pushViewController(appDetailController, animated: true)
        }
        return cell
    }
}
