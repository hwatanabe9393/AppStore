//
//  TodayController.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/14/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout{
    
//    fileprivate let cellId = "cellId"
//    fileprivate let multipleAppCellId = "multipleAppCellId"
    let items = [
        //TodayItem.init(category: "THE DAILY LIST", title: "Test-Drive These CarPlay Apps", image: #imageLiteral(resourceName: "garden"), description: "", backgrounColor: .white, cellType: .multiple),
        TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgrounColor: .white, cellType: .single),
        TodayItem.init(category: "HOLIDAY", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgrounColor: #colorLiteral(red: 0.9853913188, green: 0.9642749429, blue: 0.7255596519, alpha: 1), cellType: .single)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0{
            return CGSize(width: view.frame.width - 64, height: 500)
        }
        return CGSize(width: view.frame.width - 64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    var startingFrame: CGRect?
    var appFullScreenController: AppFullScreenController!
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appFullScreenController = AppFullScreenController()
        appFullScreenController.todayItem = items[indexPath.row]
        appFullScreenController.dismiss = handleRemoveAppFullScreenView
        let appFullScreenView = appFullScreenController.view!
        appFullScreenView.layer.cornerRadius = 16
        self.appFullScreenController = appFullScreenController
        
        view.addSubview(appFullScreenView)
        addChild(appFullScreenController)
        collectionView.isUserInteractionEnabled = false
        if let cell = collectionView.cellForItem(at: indexPath){
            // Absolute coordinates of cell
            if let startingFrame = cell.superview?.convert(cell.frame, to: nil){
                self.startingFrame = startingFrame
                
                appFullScreenView.translatesAutoresizingMaskIntoConstraints = false
                
                topConstraint = appFullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
                leadingConstraint = appFullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
                widthConstraint = appFullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
                heightConstraint = appFullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
                [topConstraint,leadingConstraint,widthConstraint, heightConstraint].forEach{$0?.isActive = true}
                self.view.layoutIfNeeded()
                
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                    
                    self.topConstraint?.constant = 0
                    self.leadingConstraint?.constant = 0
                    self.widthConstraint?.constant = self.view.frame.width
                    self.heightConstraint?.constant = self.view.frame.height
                    
                    self.view.layoutIfNeeded()
                    
                    self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
                    
                    guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else{
                        return
                    }
                    cell.todayCell.topConstraint.constant = 48
                    cell.layoutIfNeeded()
                    
                }, completion: nil)
            }
        }
    }
    
    @objc func handleRemoveAppFullScreenView(){
        if let startingFrame = startingFrame{
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                self.appFullScreenController.tableView.contentOffset = .zero
                self.topConstraint?.constant = startingFrame.origin.y
                self.leadingConstraint?.constant = startingFrame.origin.x
                self.widthConstraint?.constant = startingFrame.width
                self.heightConstraint?.constant = startingFrame.height
                self.view.layoutIfNeeded()
                
                guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else{
                    return
                }
                cell.todayCell.topConstraint.constant = 24
                cell.layoutIfNeeded()
                
                self.tabBarController?.tabBar.transform = .identity
            }) { _ in
                self.appFullScreenController.view?.removeFromSuperview()
                self.appFullScreenController.removeFromParent()
                self.collectionView.isUserInteractionEnabled = true
            }
        }else{
            self.appFullScreenController.view?.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
            self.tabBarController?.tabBar.transform = .identity
            collectionView.isUserInteractionEnabled = true
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = items[indexPath.item].cellType
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.rawValue, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        return cell
    }
}
