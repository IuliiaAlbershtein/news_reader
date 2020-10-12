//
//  ArticlesViewController.swift
//  NewsReader
//
//  Created by LocaJuli on 14/08/2020.
//  Copyright © 2020 Iuliia Albershtein. All rights reserved.
//

import UIKit

class ArticlesViewController: UITableViewController {

    private let articleStore = ArticleStore()
    private let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                    action: #selector(handleRefreshControl),
                                       for: .valueChanged)
        
        tableView.rowHeight = 190
        
        downloadData(Consts.newsApiApple)
    }
    
    override func tableView(_ tableView: UITableView,
          numberOfRowsInSection section: Int) -> Int {
        
        return articleStore.allArticles.count
    }
    
    
    override func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell",
                                                            for: indexPath) as! ArticleCell
        
        // Create call for the article in the array
        let article = articleStore.allArticles[indexPath.row]

        let formattedDate = dateFormatter.string(from: article.publishedAt)

        // Configure the cell with the Article
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.description
        cell.dateLabel.text = formattedDate
        cell.titleLabel.lineBreakMode = .byWordWrapping
        cell.titleLabel.numberOfLines = 2
        cell.descriptionLabel.lineBreakMode = .byWordWrapping
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
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.article = article
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    private func downloadData(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        Downloader.load(URLData: url, articleList: articleStore)
        
        do {
            sleep(4)
        }
        print("\(articleStore.allArticles)")
    }
    
    @objc private func handleRefreshControl() {
        articleStore.removeArticles()
        
        downloadData(Consts.newsApiTechCrunch)
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
}
