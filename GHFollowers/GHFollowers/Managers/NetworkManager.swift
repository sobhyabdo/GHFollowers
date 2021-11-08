//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Abdelrahman Sobhy on 6/6/21.
//

import UIKit

class NetworkManager {
    
    static let shered = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {
    }
    
    func getFollowers (for userName: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endPoint = baseUrl + "\(userName)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invaildUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToConnect))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToConnect))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invaildData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase                     // here i make keyDecodingStrategy to convert object from snakCase to camalCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invaildData))
            }
            
        }
        
        task.resume()
    }
    
    func getUserInfo(for userName: String, completed: @escaping (Result<User, GFError>) -> Void)  {
        let endPoint = baseUrl + "\(userName)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invaildUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToConnect))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToConnect))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invaildData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase                     // here i make keyDecodingStrategy to convert object from snakCase to camalCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invaildData))
            }
            
        }
        
        task.resume()
    }
}
