//
//  DataStore.swift
//  WHUT
//
//  Created by Nic Demai on 12/4/20.
//

import SwiftUI
import Combine
import Foundation

class Api {
    func getPosts(completion: @escaping ([Post]) -> ()) {
        let url = URL(string: "https://uinames.com/api/?amount=5")!
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        .resume()
    }
}

struct Post: Codable, Hashable, Identifiable {
    var id = UUID()
    let name: String
    var region: String
}

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    @Published var courses: [Course] = []
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
}
