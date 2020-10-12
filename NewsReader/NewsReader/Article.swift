//
//  Article.swift
//  NewsReader
//
//  Created by LocaJuli on 13/08/2020.
//  Copyright © 2020 Iuliia Albershtein. All rights reserved.
//

import UIKit

class Article {
    
    let title: String
    let description: String
    let content: String
    let publishedAt: Date
    let imageUrl: URL
    
    init(title: String, description: String, content: String, publishedAt: Date, imageUrl: URL) {
        self.title = title
        self.description = description
        self.content = content
        self.publishedAt = publishedAt
        self.imageUrl = imageUrl
    }
}
