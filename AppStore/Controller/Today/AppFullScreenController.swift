//
//  AppFullScreenController.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/14/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {
    
    @objc var dismiss: (()->())!
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        let height = UIApplication.shared.statusBarFrame.height
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 450
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = AppFullScreenHeaderCell()
            cell.closeButton.addTarget(self, action: #selector(dismissHandler), for: .touchUpInside)
            cell.todayCell.todayItem = todayItem
            cell.todayCell.layer.cornerRadius = 0
            return cell
        }
        
        let cell = AppFullScreenDescriptionCell(style: .default, reuseIdentifier: nil)
        return cell
    }
    
    @objc func dismissHandler(){
        if let cell = tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell{
            cell.closeButton.isHidden = true
        }
        dismiss()
    }
}
