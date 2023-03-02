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
    public static var isLoading:Bool = false
    
    enum ApiDataError:Error{
        case invalidURL
        case invalidData
    }
    
    static func getDataFromUrl(subreddit:String, limit:Int, after:String) async -> () {
        if isLoading {
            return
        }
        isLoading = true
        self.posts = []
        let urlString = after.isEmpty ? "https://www.reddit.com/r/\(subreddit)/top.json?limit=\(limit)"
                                      : "https://www.reddit.com/r/\(subreddit)/top.json?limit=\(limit)&after=\(after)"
        print(urlString)
        guard let url = URL(string: urlString)
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
                let post = Post(data: apiData, dataToGetAfter: decodedData.data)
                APIDataProcessor.posts.append(post)
            }
            isLoading = false
            NotificationCenter.default.post(Notification(name: APIDataProcessor.postsLoadedNotificationName))
        }catch{
            print("Invalid data!")
            return
        }
    }
}
    
