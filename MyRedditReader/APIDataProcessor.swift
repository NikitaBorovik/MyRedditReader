//
//  APIDataProcessor.swift
//  MyRedditReader
//
//  Created by Никита Боровик on 23.02.2023.
//

import Foundation


class APIDataProcessor{
    
    enum ApiDataError:Error{
        case invalidURL
        case invalidData
    }
    
    func getDataFromUrl(subreddit:String, limit:Int, after:String) async -> Result<Post,Error> {
        guard let url = URL(string: "https://www.reddit.com/r/\(subreddit)/top.json?limit=\(limit)")
        else{
            return .failure(ApiDataError.invalidURL)
        }
        do {
            let (dataReceived, _) = try await URLSession.shared.data(from: url)
            
            let decodedData = try JSONDecoder().decode(OuterPostData.self, from: dataReceived)
            guard let apiData = decodedData.data.children.first?.data else{
                return .failure(ApiDataError.invalidData)
            }
            let post = Post(data: apiData)
            return .success(post)
        }catch{
            return .failure(error)
        }
    }
}
    
