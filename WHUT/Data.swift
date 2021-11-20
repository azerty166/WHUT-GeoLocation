//
//  Data.swift
//  WHUT
//
//  Created by Nic Demai on 12/5/20.
//
//
//import SwiftUI
//
//struct Post: Codable, Identifiable {
//    let id = UUID()
//    var title: String
//    var body: String
//}
//
//class Api {
//    func getPosts(completion: @escaping ([Post]) -> ()) {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, _, _) in
//            guard let data = data else { return }
//
//            let posts = try! JSONDecoder().decode([Post].self, from: data)
//
//            DispatchQueue.main.async {
//                completion(posts)
//            }
//        }
//        .resume()
//    }
//}
