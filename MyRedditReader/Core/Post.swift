//
//  Post.swift
//  MyRedditReader
//
//  Created by Нікіта Боровік on 23.02.2023.
//

import Foundation


struct Post{
     var username: String
     var numComments: Int
     var title: String
     var domain: String
     var timePassed: String
     var rating:Int
     var imageUrl: URL?
     var saved: Bool
    
    init(data:ApiPostData){
        self.username = data.username
        self.numComments = data.numComments
        self.title = data.title
        self.domain = data.domain
        self.rating = data.ups + data.downs
        self.timePassed = data.created.makeTimeString
        self.imageUrl = data.preview?.images.first?.source.url.formattedURL
        self.saved = Bool.random()
       
    }
}


