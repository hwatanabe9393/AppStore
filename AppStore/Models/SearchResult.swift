//
//  SearchResult.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 3/24/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
    
}

struct Result: Decodable{
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String //app icon
    
    var formattedPrice: String?
    let description: String
    var releaseNotes: String?
}
