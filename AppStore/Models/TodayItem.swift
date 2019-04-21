//
//  TodayItem.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/16/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

struct TodayItem {
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgrounColor: UIColor
    
    //enum
    let cellType: CellType
    enum CellType: String{
        case single, multiple
    }
}

