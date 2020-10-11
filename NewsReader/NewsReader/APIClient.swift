//
//  APIClient.swift
//  NewsReader
//
//  Created by LocaJuli on 12/08/2020.
//  Copyright © 2020 Iuliia Albershtein. All rights reserved.
//

import UIKit

//http://newsapi.org/v2/everything?q=Apple&from=2020-08-11&sortBy=popularity&apiKey=d4994d8a3eec48658aab1d9ffd9dd49d

class Downloader {
    class func load(URLData: URL, articleList: ArticleStore) {

        let session = URLSession(configuration: .default)
        var request = URLRequest(url: URLData)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            guard let response = response as? HTTPURLResponse else { return }
            guard let data = data, response.statusCode == 200 else {
                if let error = error {
                    print("Invalid url response: \(error.localizedDescription)")
                } else {
                    print("Invalid url response: \(response.statusCode)")
                }
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else {
                print("Cannot parse JSON")
                return
            }

            guard let articles = json["articles"] as? [Any] else {
                print("Cannot parse 'articles'. Field is not an array")
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            
            for articleRecord in articles {
                guard let articleJson = articleRecord as? [String:Any] else {
                    print("Cannot parse article record")
                    continue
                }
                
                guard let dateString = articleJson["publishedAt"] as? String,
                      let publishedAt = dateFormatter.date(from: dateString) else {
                    print("Cannot parse 'publishedAt'")
                    continue
                }
                
                guard let title = articleJson["title"] as? String,
                      let description = articleJson["description"] as? String,
                      let content = articleJson["content"] as? String else { continue }
                
                let article = Article(title: title,
                                description: description,
                                    content: content,
                                publishedAt: publishedAt)
                
                articleList.addArticle(newArticle: article)
                
                guard let imageUrlString = articleJson["urlToImage"] as? String,
                      let imageUrl = URL(string: imageUrlString) else {
                    print("Cannot parse 'urlToImage'")
                    continue
                }
                
                loadImage(URL: imageUrl, article: article)
            }
        })
        task.resume()
    }
    class func loadImage(URL: URL, article: Article) {
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            guard let response = response as? HTTPURLResponse else { return }
            guard let data = data, response.statusCode == 200 else {
                if let error = error {
                    print("Invalid url response: \(error.localizedDescription)")
                } else {
                    print("Invalid url response: \(response.statusCode)")
                }
                return
            }
            
            let image = UIImage(data: data)
            article.image = image
        })
        task.resume()
    }
}




