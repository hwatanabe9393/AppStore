//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 3/21/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit
import SDWebImage

class AppsSearchController: BaseListController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    fileprivate let cellId = "id1234"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set collection view parameters
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50))
        
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar(){
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    
    //MARK:- Timer
    var searchTimer: Timer?
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // put some delay before search
        // throttling the search
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            Service.shared.fetchApps(searchTerm: searchText) {[weak self] (result, error) in
                self?.appResults = result?.results ?? []
                if let err = error{
                    print("Failed to fetch apps:", err)
                    return
                }
                
                DispatchQueue.main.async {[weak self] in
                    self?.collectionView.reloadData()
                }
            }
        })
    }
    
    //MARK:- API
    fileprivate var appResults = [Result]()
    fileprivate func fetchITunesApps(){
        Service.shared.fetchApps(searchTerm: "instagram") {[weak self] (results, error) in
            guard error == nil else{
                print("Failed to fetch apps: \(error!)")
                return
            }
            
            self?.appResults = results?.results ?? []
            DispatchQueue.main.async {[weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = String(appResults[indexPath.item].trackId)
        let appDetailController = AppDetailController(appId: appId)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    //MARK:- UICollection View Data Source
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        let appReult = appResults[indexPath.item]
        cell.result = appReult
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = (appResults.count != 0)
        return appResults.count
    }
    
    //MARK:- Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
}

