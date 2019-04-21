//
//  AppGroup.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 3/27/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable{
    let id, name, artistName, artworkUrl100: String
}
