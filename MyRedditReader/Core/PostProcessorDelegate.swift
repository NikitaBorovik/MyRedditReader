//
//  PostTableCellDelegate.swift
//  MyRedditReader
//
//  Created by Нікіта Боровік on 09.03.2023.
//

import Foundation

protocol PostProcessorDelegate:AnyObject{
    func savePost(post: Post)
    func sharePost(url: URL)
}
