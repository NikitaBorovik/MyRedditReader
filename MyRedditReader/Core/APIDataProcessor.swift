//
//  APIDataProcessor.swift
//  MyRedditReader
//
//  Created by Нікіта Боровік on 23.02.2023.
//

import Foundation


class APIDataProcessor{
    
    public static let postsLoadedNotificationName = Notification.Name("ua.edu.ukma.postsLoadedNotification")
    public static var posts:[Post] = []
    
    enum ApiDataError:Error{
        case invalidURL
        case invalidData
    }
    
    func getDataFromUrl(subreddit:String, limit:Int, after:String) async -> () {
        guard let url = URL(string: "https://www.reddit.com/r/\(subreddit)/top.json?limit=\(limit)")
        else{
            print("Invalid URL!")
            return
        }
        print("Here")
        do {
            let (dataReceived, _) = try await URLSession.shared.data(from: url)
            
            let decodedData = try JSONDecoder().decode(OuterPostData.self, from: dataReceived)
            for child in decodedData.data.children{
                let apiData = child.data
                let post = Post(data: apiData)
                APIDataProcessor.posts.append(post)
            }
 //           decodedData.data.children[1].data //else{
//                return .failure(ApiDataError.invalidData)
//            }
//            let post = Post(data: apiData)
            NotificationCenter.default.post(Notification(name: APIDataProcessor.postsLoadedNotificationName))
        }catch{
            print("Invalid data!")
            return
        }
    }
}
    
