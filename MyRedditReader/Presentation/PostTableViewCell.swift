//
//  CustomPostCell.swift
//  MyRedditReader
//
//  Created by Нікіта Боровік on 02.03.2023.
//

import Foundation
import UIKit
import SDWebImage

final class PostTableViewCell: UITableViewCell{
    
    @IBOutlet private weak var postView: PostView!
    
    private var post:Post?
    weak var delegate:PostProcessorDelegate?
    private var bookmarkView: UIView = UIView()
    
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
        addImageDoubleTapRecognizer()
    }
    
    
//    private func addSubviewForBookmark(to imageView: UIImageView){
//        imageView.subviews.forEach{$0.removeFromSuperview()}
//        bookmarkView.backgroundColor = .clear
//        bookmarkView.frame = CGRect(
//            origin: CGPoint(
//                x: imageView.bounds.midX - Const.bookmarkViewWidth / 2.0,
//                y: imageView.bounds.midY - Const.bookmarkViewHeigth / 2.0
//                ),
//            size: CGSize(width: Const.bookmarkViewWidth,
//                         height: Const.bookmarkViewHeigth)
//        )
//        Drawer.drawBookmark(on: bookmarkView)
//        imageView.addSubview(bookmarkView)
//
//    }
    
    private func addImageDoubleTapRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animatedSave))
        gestureRecognizer.delaysTouchesBegan = true
        gestureRecognizer.numberOfTapsRequired = 2
        postView.image.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc
    private func animatedSave(){
        guard let post else {return}
        postView.addSubviewToImage(view: bookmarkView)
        bookmarkView.isHidden = false
        UIView.animate(withDuration: Const.saveAnimationDuration,
                       delay: 0,
                       usingSpringWithDamping: Const.saveAnimationSpringDamping,
                       initialSpringVelocity: Const.initialSaveAnimationVelocity
        ) {
        self.bookmarkView.transform = CGAffineTransform(
            scaleX: Const.finalBookmarkScale,
            y: Const.finalBookmarkScale
        )
        } completion: { _ in
        if (!post.saved){
            self.saveButtonHadler()
        }
        self.bookmarkView.isHidden = true
        self.bookmarkView.transform = CGAffineTransform(
            scaleX: Const.initialBookmarkScale,
            y: Const.initialBookmarkScale)
    }
}
    
    
    @objc
    private func saveButtonHadler(){
        guard let post else {return}
        delegate?.savePost(post: post)
    }
    
    @objc
    private func shareButtonHandler(){
            guard let url = post?.url else {return}
            delegate?.sharePost(url: url)
    }
}

