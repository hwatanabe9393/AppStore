//
//  Extensions.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 3/26/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

extension UILabel{
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1){
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}
