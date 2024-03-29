//
//  PostDetailsViewController.swift
//  MyRedditReader
//
//  Created by Нікіта Боровік on 03.03.2023.
//

import Foundation
import UIKit

final class PostDetailsViewController: UIViewController{
    
    @IBOutlet private weak var postView: PostView!
    
    weak var delegate: PostProcessorDelegate?
    private var bookmarkView: UIView = UIView()
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config(with: post)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        postView.addSubviewToImage(view: bookmarkView)
    }
    
    func config(with post: Post?){
        DispatchQueue.main.async { [self] in
            guard let data = post else {
                return
            }
            
            self.postView.usernameLable.text = data.username
            self.postView.timeLable.text = data.timePassed
            self.postView.domainLable.text = data.domain
            self.postView.titleLable.text = data.title
            self.postView.ratingLable.text = String(data.rating)
            self.postView.commentsButton.setTitle(String(data.numComments), for: .normal)
            if data.saved {
                self.postView.savedButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            }else{
                self.postView.savedButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            }
            self.postView.image.sd_setImage(with: data.imageUrl,placeholderImage: UIImage(systemName: "face.smiling"))
            self.postView.savedButton.addTarget(self, action: #selector(saveButtonHadler), for: .touchUpInside)
            self.postView.shareButton.addTarget(self, action: #selector(shareButtonHandler), for: .touchUpInside)
            addImageDoubleTapRecognizer()
        }
        
    }
    private func addImageDoubleTapRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animatedSave))
        gestureRecognizer.numberOfTapsRequired = 2
        postView.image.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc
    private func animatedSave(){
        guard let post else {return}
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
    func saveButtonHadler(){
        guard let post else {return}
        post.saved ? postView.savedButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        :postView.savedButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        delegate?.savePost(post: post)
        self.post?.saved.toggle()
    }
    
    @objc
    func shareButtonHandler(){
        guard let url = post?.url else {return}
        delegate?.sharePost(url: url)
    }
}
