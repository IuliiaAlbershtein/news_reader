//
//  ArticlesViewController.swift
//  NewsReader
//
//  Created by LocaJuli on 14/08/2020.
//  Copyright © 2020 Iuliia Albershtein. All rights reserved.
//

import UIKit
// creating of subclass
class ArticlesViewController: UITableViewController {
    // property of ArticleViewController
    var articleStore: ArticleStore!
    
    func DownloadData() {
    let url = URL(string: "http://newsapi.org/v2/everything?q=Apple&from=2020-08-11&sortBy=popularity&apiKey=d4994d8a3eec48658aab1d9ffd9dd49d")

        //var articleList = ArticleStore()
      
        Downloader.load(URL: url!, articleList: articleStore)
        do {
            sleep(1)
        }
        print("\(articleStore.allArticles)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 125
        DownloadData()
        
    }
    
    override func tableView(_ tableView: UITableView,
       numberOfRowsInSection section: Int) -> Int {
        return articleStore.allArticles.count
    }
    
    
    override func tableView(_ tableView: UITableView,
            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*// Create an instance of UITableViewCell with default appearance
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        */
        // Get a new or recycled cell
            //let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
               // for: indexPath)
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell",
                                                         for: indexPath) as! ArticleCell
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the table view
        let article = articleStore.allArticles[indexPath.row]

        //cell.textLabel?.text = item.name
        //cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        // Configure the cell with the Item
            cell.titleLabel.text = article.title
            cell.descriptionLabel.text = article.description
            cell.dateLabel.text = "\(article.datePublished)"
            cell.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.titleLabel.numberOfLines = 3
            //cell.descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            //cell.descriptionLabel.numberOfLines = 3
        
        return cell
    }
    
}

