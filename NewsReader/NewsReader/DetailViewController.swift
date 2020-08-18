//
//  DetailViewController.swift
//  NewsReader
//
//  Created by LocaJuli on 18/08/2020.
//  Copyright © 2020 Iuliia Albershtein. All rights reserved.
//

import UIKit
class DetailViewController: UIViewController {
    @IBOutlet weak var titleDetail: UILabel!
    
    @IBOutlet weak var dateDetail: UILabel!
    
    @IBOutlet weak var descriptionDetail: UILabel!
    
    @IBOutlet weak var contentDetail: UILabel!
    
    //var articleStore: ArticleStore!
    //var article: Article!
    //var article = articleStore.allArticles[indexPath.row]

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            titleDetail.text = article.title
            dateDetail.text = "\(article.datePublished)"
            descriptionDetail.text = article.description
            contentDetail.text = article.content
        }
}
