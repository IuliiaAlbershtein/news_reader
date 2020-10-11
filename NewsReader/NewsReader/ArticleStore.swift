//
//  ArticleStore.swift
//  NewsReader
//
//  Created by LocaJuli on 13/08/2020.
//  Copyright © 2020 Iuliia Albershtein. All rights reserved.
//

import UIKit

class ArticleStore {
    var allArticles = [Article]()

    func addArticle(newArticle: Article) {
        allArticles.append(newArticle)
    }
    func removeArticles() {
        allArticles = [Article]()
    }

}
