//
//  DetailViewController.swift
//  NewsReader
//
//  Created by LocaJuli on 18/08/2020.
//  Copyright © 2020 Iuliia Albershtein. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageDetailView: UIImageView!
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var dateDetail: UILabel!
    @IBOutlet weak var contentDetail: UILabel!
    
    var article: Article!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let formattedDate = dateFormatter.string(from: article.publishedAt)
        titleDetail.text = article.title
        dateDetail.text = formattedDate
        contentDetail.text = article.content
        imageDetailView.image = article.image
    }
}
