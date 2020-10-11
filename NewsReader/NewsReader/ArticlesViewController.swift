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
    
    
    func downloadData(_ weblink: String) {
        let url = URL(string: weblink)
        
        //var articleList = ArticleStore()
        
        Downloader.load(URLData: url!, articleList: articleStore)
        do {
            sleep(4)
        }
        print("\(articleStore.allArticles)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action:
            #selector(handleRefreshControl),
                                            for: .valueChanged)
        
        
        tableView.rowHeight = 190
        
        downloadData("http://newsapi.org/v2/everything?q=Apple&sortBy=popularity&apiKey=d4994d8a3eec48658aab1d9ffd9dd49d")
        
    }
    @objc func handleRefreshControl() {
        print("hghghg")
        articleStore.removeArticles()
        
        downloadData("http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=d4994d8a3eec48658aab1d9ffd9dd49d")
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return articleStore.allArticles.count
    }
    
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell",
                                                 for: indexPath) as! ArticleCell
        
        // Create a reference to the article, which is in the array
        let article = articleStore.allArticles[indexPath.row]
        
          let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        let formattedDate = dateFormatter.string(from: article.datePublished)
        // Configure the cell with the Article
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.descr
        cell.dateLabel.text = "\(formattedDate)"
        cell.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.titleLabel.numberOfLines = 2
        cell.descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.descriptionLabel.numberOfLines = 4
        cell.descriptionLabel.adjustsFontSizeToFitWidth = false
        cell.descriptionLabel.lineBreakMode = .byTruncatingTail
        cell.newsImageView.image = article.image
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the triggered segue is the "showArticle" segue
        switch segue.identifier {
        case "showArticle":
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                // Get the item associated with this row and pass it along
                let article = articleStore.allArticles[row]
                let detailViewController
                    = segue.destination as! DetailViewController
                detailViewController.article = article
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    // Button to save the article to read later
    @IBAction func ButtonClicked(_ sender: Any) {

        guard let row = tableView.indexPathForSelectedRow?.row else { return }
        
        // Get the item associated with this row and pass it along
        let article = articleStore.allArticles[row]
        let userDefaults = UserDefaults.standard
        do {
            let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: article, requiringSecureCoding: false)
            userDefaults.set(encodedData, forKey: "article")
            userDefaults.synchronize()
            print("saving \(article.title)")
        } catch {
            print("error very unknown")
        }
        
    }
    
}
