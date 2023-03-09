//
//  PostTableCellDelegate.swift
//  MyRedditReader
//
//  Created by Никита Боровик on 09.03.2023.
//

import Foundation

protocol PostProcessorDelegate:AnyObject{
    func savePost(post: Post)
    func sharePost(url: URL)
}
