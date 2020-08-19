//
//  APIClient.swift
//  NewsReader
//
//  Created by LocaJuli on 12/08/2020.
//  Copyright © 2020 Iuliia Albershtein. All rights reserved.
//

import UIKit
import SwiftyJSON

//http://newsapi.org/v2/everything?q=Apple&from=2020-08-11&sortBy=popularity&apiKey=d4994d8a3eec48658aab1d9ffd9dd49d

class Downloader {
    class func load(URLData: URL, articleList: ArticleStore) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: URLData)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler: { (data: Data!, response: URLResponse!, error: Error!) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("Success: \(statusCode)")
                var json = JSON.null
                do {
                // This is your file-variable:
                let rawJson = data
                    json = try JSON(data: rawJson!)
                } catch {
                    print("Issue with data file")
                }
                let articles = json["articles"].arrayValue // array
                
                for articleData in articles {
                    let date = articleData["publishedAt"].stringValue
                    let dateFor: DateFormatter = DateFormatter()
                    dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                    
                    
                    let yourDate: Date? = dateFor.date(from: date)
                   // print("\(String(describing: yourDate))")
                    //print("\(article["title"].stringValue)")
                    let article = Article(articleData["title"].stringValue, articleData["description"].stringValue, articleData["content"].stringValue, yourDate!);
                    articleList.addArticle(newArticle: article)
                    let imageUrl = URL(string: articleData["urlToImage"].stringValue)
                    loadImage(URL: imageUrl!, article: article)
                }
            }
            else {
                // Failure
                print("Failure: %@", error.localizedDescription);
            }
        })
        task.resume()
    }
    class func loadImage(URL: URL, article: Article) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler: { (data: Data!, response: URLResponse!, error: Error!) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("Success: \(statusCode)")
                //object creation
                let image = UIImage(data: data)
                article.image = image
            } else {
                // Failure
                print("Failure: %@", error.localizedDescription);
            }
        })
        task.resume()
    }
}




