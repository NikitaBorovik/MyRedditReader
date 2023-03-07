//
//  PostListViewController.swift
//  MyRedditReader
//
//  Created by Никита Боровик on 02.03.2023.
//

import UIKit
import SDWebImage

class PostListViewController: UIViewController{
    
    @IBOutlet private weak var subredditNameLabel: UILabel!
    
    @IBOutlet private weak var tableView: UITableView!
    
    struct Const {
        static let cellReuseId = "custom_post_cell"
        static let goToDetailsSeagueId = "go_to_details"
        static let postsCountInOneTime = 20
    }
    
    private var postList: [Post] = []
    private var lastSelectedPost: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.subredditNameLabel.text = "/r/\(APIDataProcessor.subredditName)"
        }
        self.tableView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(recalculateData), name: APIDataProcessor.postsLoadedNotificationName, object: nil)
    }
    
    
    
    @objc
    func recalculateData(){
        if APIDataProcessor.posts.isEmpty{
            return
        }
        DispatchQueue.main.async {
            [self] in
            self.postList += APIDataProcessor.posts
            self.tableView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case Const.goToDetailsSeagueId:
            let nextVc = segue.destination as! PostDetailsViewController
            DispatchQueue.main.async {
                nextVc.config(with: self.lastSelectedPost)
            }
        default: break
        }
    }
}

extension PostListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Const.postsCountInOneTime
        self.postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Const.cellReuseId,
            for: indexPath
        ) as! PostTableViewCell
        
        let particularPost = self.postList[indexPath.row]
        cell.config(with: particularPost)
        
        return cell
    }
    
    
}

extension PostListViewController: UITableViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let heigth = scrollView.frame.size.height
        let contentOffsY = scrollView.contentOffset.y
        let dist = scrollView.contentSize.height - contentOffsY
        if dist < heigth*2 {
            Task{await APIDataProcessor.getDataFromUrl(subreddit: "cats", limit: Const.postsCountInOneTime, after: postList.last?.after ?? "")}
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.lastSelectedPost = self.postList[indexPath.row]
        self.performSegue(withIdentifier: Const.goToDetailsSeagueId, sender: nil)
    }
}

