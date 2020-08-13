//
//  ViewController.swift
//  NewsReader
//
//  Created by LocaJuli on 12/08/2020.
//  Copyright © 2020 Iuliia Albershtein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: "http://newsapi.org/v2/everything?q=Apple&from=2020-08-11&sortBy=popularity&apiKey=d4994d8a3eec48658aab1d9ffd9dd49d")

        var articleList = ArticleStore()
        
        Downloader.load(URL: url!, articleList: articleList)
        do {
            sleep(4)
        } 
        print("\(articleList.allArticles)")
    }


}

