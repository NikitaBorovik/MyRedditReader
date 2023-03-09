//
//  Post.swift
//  MyRedditReader
//
//  Created by Нікіта Боровік on 23.02.2023.
//

import Foundation


struct Post: Codable{
    let username: String
    let numComments: Int
    let title: String
    let domain: String
    let timePassed: String
    let rating:Int
    let imageUrl: URL?
    var saved: Bool
    let after: String
    let url: URL?
    
    init(data:ApiPostData, dataToGetAfter: InnerPostData){
        self.username = data.username
        self.numComments = data.numComments
        self.title = data.title
        self.domain = data.domain
        self.rating = data.ups + data.downs
        self.timePassed = data.created.makeTimeString
        self.imageUrl = data.preview?.images.first?.source.url.formattedURL
        self.saved = false
        self.after = dataToGetAfter.after
        self.url = URL(string: "https://www.reddit.com\(data.permalink)")
        
    }
}

extension Post:Equatable{
    static func ==(left:Post,right:Post) -> Bool{
        left.url == right.url
    }
}


