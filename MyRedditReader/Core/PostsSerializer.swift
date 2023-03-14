//
//  PostsSaverAndLoader.swift
//  MyRedditReader
//
//  Created by Нікіта Боровік on 09.03.2023.
//

import Foundation

class PostsSerializer{
    
    var postsInSave:[Post] = []
    public static var instance = PostsSerializer()
    
    public init(){
        loadPosts()
    }
    
    func savePosts() {
        let jsEncoder = JSONEncoder()
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("mySavedPosts.json") {
            jsEncoder.outputFormatting = .prettyPrinted
            if let data = try? jsEncoder.encode(postsInSave) {
                do {
                    try data.write(to: path, options: .atomic)
                } catch {
                    print("Cannot write to file")
                }
            }
        }
        
    }
    func loadPosts(){
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("mySavedPosts.json") {
            do{
                let data = try Data(contentsOf: path)
                self.postsInSave = try JSONDecoder().decode([Post].self, from: data)
            }catch{
                print("Cannot load from file")
            }
        }
    }
}
