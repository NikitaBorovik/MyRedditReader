//
//  PostsSaverAndLoader.swift
//  MyRedditReader
//
//  Created by Никита Боровик on 09.03.2023.
//

import Foundation

class PostsSaverAndLoader{
    
    var postsInSave:[Post] = []
    public static var instance = PostsSaverAndLoader()
    
    public init(){
        loadPosts()
    }
    
    func savePosts() {
        let jsEncoder = JSONEncoder()
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("savedPosts.json") {
            print(path)
            jsEncoder.outputFormatting = .prettyPrinted
            if let data = try? jsEncoder.encode(postsInSave) {
                do {
                    print("asdasda")
                    try data.write(to: path, options: .atomic)
                } catch {
                    print("Error writing data to file: \(error)")
                }
            }
        }
        print("Success!")
    }
    func loadPosts(){
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("savedPosts.json") {
            do{
                let data = try Data(contentsOf: path)
                self.postsInSave = try JSONDecoder().decode([Post].self, from: data)
            }catch{
                print(error)
            }
        }
        for post in postsInSave{
            print("Post \(post)")
            print()
        }
    }
}
