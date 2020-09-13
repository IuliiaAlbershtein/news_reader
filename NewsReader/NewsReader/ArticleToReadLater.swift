//
//  ArticleToReadLater.swift
//  NewsReader
//
//  Created by LocaJuli on 05/09/2020.
//  Copyright © 2020 Iuliia Albershtein. All rights reserved.
//

import UIKit

class ArticleToReadLater: UITableViewController {
// property of ArticleViewController
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 190
    }
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 1
    }
   
    override func tableView(_ tableView: UITableView,
                               cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.data(forKey: "article")
        let cellReadLater = tableView.dequeueReusableCell(withIdentifier: "ArticleCellRead",
        for: indexPath) as! ArticleCellRead
        if decoded == nil {
                print("nine")
        } else {
            let decodedArticle = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! Article
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale(identifier: "en_US")
            let formattedDate = dateFormatter.string(from: decodedArticle.datePublished)
            // Configure the cell with the Item
            cellReadLater.titleReadLaterLabel.text = decodedArticle.title
            cellReadLater.descriptionReadLaterLabel.text = decodedArticle.descr
            cellReadLater.dateReadLaterLabel.text = "\(formattedDate)"
            cellReadLater.titleReadLaterLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            cellReadLater.titleReadLaterLabel.numberOfLines = 2
            cellReadLater.descriptionReadLaterLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            cellReadLater.descriptionReadLaterLabel.numberOfLines = 4
            cellReadLater.descriptionReadLaterLabel.adjustsFontSizeToFitWidth = false
            cellReadLater.descriptionReadLaterLabel.lineBreakMode = .byTruncatingTail
            cellReadLater.newsImageReadLaterView.image = decodedArticle.image
        }
        return cellReadLater
    }
}
