//
//  ViewController.swift
//  MyRedditReader
//
//  Created by Никита Боровик on 22.02.2023.
//

import UIKit
import SDWebImage

class PostViewController: UIViewController {

    @IBOutlet weak var usernameLable: UILabel!
    
    @IBOutlet weak var timeLable: UILabel!
    
    @IBOutlet weak var domainLable: UILabel!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet private weak var image: UIImageView!
    
    @IBOutlet weak var savedButton: UIButton!
    
    @IBOutlet weak var commentsButton: UIButton!
    
    @IBOutlet weak var upvoteLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task{await displayDataFromPost()}
        // Do any additional setup after loading the view.
    }

    private func displayDataFromPost() async{
        let dataProcessor = APIDataProcessor()
        let data = await dataProcessor.getDataFromUrl(subreddit: "dota", limit: 1, after:"" )
        await MainActor.run{
            switch data{
            case .success(let post):
                usernameLable.text = post.username
                usernameLable.sizeToFit()
                domainLable.text = post.domain
                titleLable.text = post.title
                titleLable.sizeToFit()
                if post.saved {
                    savedButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                }
                upvoteLable.text = String(post.rating)
                commentsButton.setTitle(String(post.numComments), for: .normal)
                timeLable.text = post.timePassed
                image.sd_setImage(with: post.imageUrl,placeholderImage: UIImage(systemName: "face.smiling"))
                
            case .failure(_):
                return
            }
        }
    }

}

