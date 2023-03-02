//
//  ViewController.swift
//  MyRedditReader
//
//  Created by Нікіта Боровік on 22.02.2023.
//

import UIKit
import SDWebImage

class PostViewController: UIViewController {

    @IBOutlet private weak var usernameLable: UILabel!
    
    @IBOutlet private weak var timeLable: UILabel!
    
    @IBOutlet private weak var domainLable: UILabel!
    
    @IBOutlet private weak var titleLable: UILabel!
    
    @IBOutlet private weak var image: UIImageView!
    
    @IBOutlet private weak var savedButton: UIButton!
    
    @IBOutlet private weak var commentsButton: UIButton!
    
    @IBOutlet private weak var upvoteLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(displayDataFromPost), name: APIDataProcessor.postsLoadedNotificationName, object: nil)
        //displayDataFromPost(postR: APIDataProcessor.posts.first!)
        // Do any additional setup after loading the view.
    }

    @objc
    private func displayDataFromPost(){
        DispatchQueue.main.async {
            [self] in
            let post = APIDataProcessor.posts[3]
            self.usernameLable.text = post.username
            self.usernameLable.sizeToFit()
            self.domainLable.text = post.domain
            self.titleLable.text = post.title
            self.titleLable.sizeToFit()
            if post.saved {
                self.savedButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            }
            self.upvoteLable.text = String(post.rating)
            self.commentsButton.setTitle(String(post.numComments), for: .normal)
            self.timeLable.text = post.timePassed
            self.image.sd_setImage(with: post.imageUrl,placeholderImage: UIImage(systemName: "face.smiling"))
        }
        
                
        }
}


