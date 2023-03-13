//
//  CustomPostCell.swift
//  MyRedditReader
//
//  Created by Никита Боровик on 02.03.2023.
//

import Foundation
import UIKit
import SDWebImage

final class PostTableViewCell: UITableViewCell{
    
    @IBOutlet private weak var postView: PostView!
    
    private var post:Post?
    weak var delegate:PostProcessorDelegate?
    
    func config(with data: Post){
        post = data
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
        postView.savedButton.addTarget(self, action: #selector(saveButtonHadler), for: .touchUpInside)
        postView.shareButton.addTarget(self, action: #selector(shareButtonHandler), for: .touchUpInside)
    }
    
    @objc
    func saveButtonHadler(){
        guard let post else {return}
        delegate?.savePost(post: post)
    }
    
    @objc
    func shareButtonHandler(){
            guard let url = post?.url else {return}
            delegate?.sharePost(url: url)
    }
}

