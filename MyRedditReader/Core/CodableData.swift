//
//  CodableData.swift
//  MyRedditReader
//
//  Created by Нікіта Боровік on 24.02.2023.
//

import Foundation
struct OuterPostData: Codable{
    let data: InnerPostData
}

struct InnerPostData: Codable{
    let after: String
    let children: [Child]
}

struct Child: Codable{
    let data:ApiPostData
}

struct ApiPostData: Codable{
    let username: String
    let numComments: Int
    let title: String
    let domain: String
    let created: Double
    let ups:Int
    let downs:Int
    let preview: Preview?
    let permalink: String
    
    enum CodingKeys: String, CodingKey{
        case username = "author"
        case numComments = "num_comments"
        case title
        case domain
        case created
        case ups
        case downs
        case preview
        case permalink
    }
}
struct Preview: Codable {
    let images: [Image]
}
struct Image: Codable {
    let source: Source
}
struct Source: Codable {
    let url: String
    let width, height: Int
}
