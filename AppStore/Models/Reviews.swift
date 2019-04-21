//
//  Review.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 4/14/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

struct Reviews:Decodable {
    let feed: ReviewFeed
}

struct ReviewFeed: Decodable{
    let entry: [Entry]
}

struct Entry: Decodable {
    private enum CodingKeys: String, CodingKey{
        case author, title, content
        case rating = "im:rating"
    }
    let title: Label
    let content: Label
    let author: Author
    let rating: Label
    
}

struct Label: Decodable {
    let label: String
}

struct Author: Decodable {
    let name: Label
}
