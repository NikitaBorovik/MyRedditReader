//
//  Post.swift
//  MyRedditReader
//
//  Created by Никита Боровик on 23.02.2023.
//

import Foundation


class Post{
     var username: String = ""
     var numComments: Int = 0
     var title: String = ""
     var domain: String = ""
     var timePassed: String = ""
     var rating:Int = 0
     var imageUrl: URL?
     var saved: Bool = false
    
    init(data:ApiPostData){
        self.username = data.username
        self.numComments = data.numComments
        
        self.title = data.title
        self.domain = data.domain
        self.rating = data.ups + data.downs
        self.imageUrl = formatImageUrl(urlString: (data.preview?.images[0].source.url) ?? "")
        self.saved = Bool.random()
        self.timePassed = convertToTimeString(data.created)
    }
    private func convertToTimeString(_ created:Double) -> String{
        let timePassed = Date().timeIntervalSince1970 - TimeInterval(created)
        let dateFormater = DateComponentsFormatter()
        dateFormater.unitsStyle = .abbreviated
        dateFormater.maximumUnitCount = 1
        dateFormater.calendar?.locale = Locale(identifier: "en")
        dateFormater.allowedUnits = [.second,.minute,.hour,.day]
        let res = dateFormater.string(from: timePassed) ?? String(timePassed)
        return res
    }
    private func formatImageUrl(urlString: String)->URL?{
        return URL(string: urlString.replacingOccurrences(of: "&amp;", with: "&"))
    }
}
