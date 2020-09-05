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
        //tableView.contentInset.top = 10
        //tableView.contentInset.top = UIApplication.sharedApplication().statusBarFrame.height
        
        //tableView.contentInset = UIEdgeInsets(top: 20, left: 0.0, bottom: 0.0, right: 0.0);
        //tableView.scrollIndicatorInsets = tableView.contentInset
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action:
                                           #selector(handleRefreshControl),
                                           for: .valueChanged)
        
        
        tableView.rowHeight = 190
        
        downloadData("http://newsapi.org/v2/everything?q=Apple&from=2020-08-11&sortBy=popularity&apiKey=d4994d8a3eec48658aab1d9ffd9dd49d")
        
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        let formattedDate = dateFormatter.string(from: article.datePublished)
        // Configure the cell with the Item
            cell.titleLabel.text = article.title
            cell.descriptionLabel.text = article.description
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
        // If the triggered segue is the "showItem" segue
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
    
    @IBAction func ButtonClicked(_ sender: Any) {
        print("wuf")
    }
    
}
