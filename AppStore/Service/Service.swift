//
//  Service.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 3/24/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import Foundation

class Service {
    static let shared = Service()
    
    func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?)->()){
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        fetchGenericJASONData(urlString: urlString, completion: completion)
    }
    
    func fetchNewGamesWeLove(completion: @escaping (AppGroup?, Error?)->()){
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        fetchGenericJASONData(urlString: urlString, completion: completion)
    }
    
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?)->()){
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
        fetchGenericJASONData(urlString: urlString, completion: completion)
    }
    
    func fetchTopFree(completion: @escaping (AppGroup?, Error?)->()){
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json"
        fetchGenericJASONData(urlString: urlString, completion: completion)
    }

    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?)->Void){
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJASONData(urlString: urlString, completion: completion)
    }
    
    func fetchGenericJASONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?)->Void){
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    completion(nil, error)
                }
                if let data = data{
                    do{
                        let objects = try JSONDecoder().decode(T.self, from: data)
                        completion(objects, nil)
                    }catch let error{
                        completion(nil, error)
                    }
                }
            }.resume()
        }
    }
    
}
