//
//  ApiCall.swift
//  News
//
//  Created by Yusuf Kaan USTA on 22.08.2023.
//

import Foundation

final class ApiCall {
    static let shared = ApiCall()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=d7f2a31563784ac2a4cb65735c3c6d77")
        static let searchUrl = "https://newsapi.org/v2/everything?.sortedBy=popularity&apiKey=d7f2a31563784ac2a4cb65735c3c6d77&q="
    }
    
    private init() {}
    
    // Top Stories
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Article count: \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    // Search
    
    public func search(with query: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let urlString = Constants.searchUrl + query
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Article count: \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    // Category
    
    public func getTopStoriesByCategory(category: String, completion: @escaping (Result<[Article], Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&apiKey=d7f2a31563784ac2a4cb65735c3c6d77"
            guard let url = URL(string: urlString) else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    do {
                        let result = try JSONDecoder().decode(APIResponse.self, from: data)
                        completion(.success(result.articles))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    
    // Country
    
    public func getTopStoriesByCountry(country: String, completion: @escaping (Result<[Article], Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=d7f2a31563784ac2a4cb65735c3c6d77"
            guard let url = URL(string: urlString) else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    do {
                        let result = try JSONDecoder().decode(APIResponse.self, from: data)
                        completion(.success(result.articles))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
}

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let category: String?
    let country: String?
}

struct Source: Codable {
    let id: String?
    let name: String?
}
