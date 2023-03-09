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
    
    @IBOutlet private weak var switchModesButton: UIButton!
    
    private var postsSaverAndLoader = PostsSaverAndLoader.instance
    
    private var onlySavedPosts: Bool = false
    
    @IBAction func ChangePostsDisplayMode(_ sender: Any) {
        onlySavedPosts.toggle()
        switchPostsToShow()
    }
    
    
    struct Const {
        static let cellReuseId = "custom_post_cell"
        static let goToDetailsSeagueId = "go_to_details"
        static let postsCountInOneTime = 20
    }
    
    private var allPostsList: [Post] = []
    private var postsToShow: [Post] = []
    private var lastSelectedPost: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.subredditNameLabel.text = "/r/\(APIDataProcessor.subredditName)"
        }
        self.tableView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(recalculateData), name: APIDataProcessor.postsLoadedNotificationName, object: nil)
    }
    
    func switchPostsToShow(){
        if onlySavedPosts{
            postsToShow = allPostsList.filter({$0.saved})
            switchModesButton.setImage(UIImage(systemName: "bookmark.circle.fill"), for: .normal)
        }else{
            postsToShow = allPostsList
            switchModesButton.setImage(UIImage(systemName: "bookmark.circle"), for: .normal)
        }
        tableView.reloadData()
    }
    
    
    @objc
    func recalculateData(){
        if !onlySavedPosts{
            if APIDataProcessor.posts.isEmpty{
                self.postsToShow = postsSaverAndLoader.postsInSave
            }
            DispatchQueue.main.async {
                [self] in
                self.allPostsList += APIDataProcessor.posts
                for p1 in postsSaverAndLoader.postsInSave{
                    for index in 0..<allPostsList.count{
                        if p1 == allPostsList[index] {
                            allPostsList[index].saved = true
                        }
                    }
                }
                self.postsToShow = allPostsList
                self.tableView.reloadData()
                
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case Const.goToDetailsSeagueId:
            let nextVc = segue.destination as! PostDetailsViewController
            //DispatchQueue.main.async {
                //nextVc.config(with: self.lastSelectedPost)
            nextVc.post = self.lastSelectedPost
            nextVc.delegate = self
            //}
        default: break
        }
    }
}

extension PostListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Const.postsCountInOneTime
        self.postsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Const.cellReuseId,
            for: indexPath
        ) as! PostTableViewCell
        
        let particularPost = self.postsToShow[indexPath.row]
        cell.config(with: particularPost)
        cell.delegate = self
        
        return cell
    }
    
    
}

extension PostListViewController: UITableViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let heigth = scrollView.frame.size.height
        let contentOffsY = scrollView.contentOffset.y
        let dist = scrollView.contentSize.height - contentOffsY
        if dist < heigth*2 {
            Task{await APIDataProcessor.getDataFromUrl(subreddit: "cats", limit: Const.postsCountInOneTime, after: postsToShow.last?.after ?? "")}
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.lastSelectedPost = self.postsToShow[indexPath.row]
        self.performSegue(withIdentifier: Const.goToDetailsSeagueId, sender: nil)
    }
}

extension PostListViewController: PostProcessorDelegate{
    func savePost(post: Post) {
        
        if var postToSave = postsToShow.first(where: {$0 == post}){
            if postToSave.saved{
                postsSaverAndLoader.postsInSave = postsSaverAndLoader.postsInSave.filter {$0 != postToSave}
                print("Here1")
                tableView.reloadData()
            }else{
                postToSave.saved = true
                postsSaverAndLoader.postsInSave.append(postToSave)
                print("Here2")
                tableView.reloadData()
            }
            if let index = postsToShow.firstIndex(where: {$0 == postToSave}){
                postsToShow[index].saved.toggle()
            }
            if let index = allPostsList.firstIndex(where: {$0 == postToSave})
            {
                allPostsList[index].saved.toggle()
            }
        }
    }
    
    func sharePost(url: URL) {
        let actItems: [Any] = ["\(url)"]
        let activityVC = UIActivityViewController(activityItems: actItems, applicationActivities: nil)
        present(activityVC,animated: true)
    }
    
    
}
