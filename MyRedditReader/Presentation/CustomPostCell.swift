//
//  CustomPostCell.swift
//  MyRedditReader
//
//  Created by Никита Боровик on 02.03.2023.
//

import Foundation
import UIKit
import SDWebImage

final class CustomPostCell: UITableViewCell{
    
    @IBOutlet private weak var postView: PostView!
    
    func config(with data: Post){
        print("Help")
        postView.usernameLable.text = data.username
        postView.timeLable.text = data.timePassed
        postView.domainLable.text = data.domain
        postView.titleLable.text = data.title
        postView.ratingLable.text = String(data.rating)
        postView.commentsButton.setTitle(String(data.numComments), for: .normal)
        if data.saved {
            postView.savedButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }else{
            postView.savedButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        postView.image.sd_setImage(with: data.imageUrl,placeholderImage: UIImage(systemName: "face.smiling"))
    }
}

