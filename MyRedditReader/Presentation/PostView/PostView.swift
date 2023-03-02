//
//  PostView.swift
//  MyRedditReader
//
//  Created by Никита Боровик on 02.03.2023.
//

import UIKit

class PostView: UIView{
    
    @IBOutlet private weak var contentView: UIView!
    
    
    @IBOutlet private weak var usernameLable: UILabel!
    
    @IBOutlet private weak var timeLable: UILabel!
    
    
    @IBOutlet private weak var domainLable: UILabel!
    
    @IBOutlet private weak var titleLable: UILabel!
    
    @IBOutlet private weak var image: UIImageView!
    
    @IBOutlet private weak var savedButton: UIButton!
    
    @IBOutlet private weak var ratingLable: UILabel!
    
    @IBOutlet private weak var commentsButton: UIButton!
    
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
