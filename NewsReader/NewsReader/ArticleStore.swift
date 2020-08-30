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
    /*
    func moveItem(from fromIndex: Int, to toIndex: Int) {
            if fromIndex == toIndex {
                return
            }

            // Get reference to object being moved so you can reinsert it
            let movedItem = allItems[fromIndex]

            // Remove item from array
            allItems.remove(at: fromIndex)

            // Insert item in array at new location
            allItems.insert(movedItem, at: toIndex)
        }*/
}
