//
//  PostView.swift
//  MyRedditReader
//
//  Created by Никита Боровик on 02.03.2023.
//

import UIKit

class PostView: UIView{
    
    @IBOutlet weak var contentView: UIView!
    
    
    @IBOutlet weak var usernameLable: UILabel!
    
    @IBOutlet weak var timeLable: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var domainLable: UILabel!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var savedButton: UIButton!
    
    @IBOutlet weak var ratingLable: UILabel!
    
    @IBOutlet weak var commentsButton: UIButton!
    
    let kCONTENT_XIB_NAME = "PostView"
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
        func commonInit() {
            Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
            contentView.fixInView(self)
        }
    }

    extension UIView
    {
        func fixInView(_ container: UIView!) -> Void{
            self.translatesAutoresizingMaskIntoConstraints = false;
            self.frame = container.frame;
            container.addSubview(self);
            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        }
    }
