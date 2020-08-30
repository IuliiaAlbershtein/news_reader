//
//  Article.swift
//  NewsReader
//
//  Created by LocaJuli on 13/08/2020.
//  Copyright © 2020 Iuliia Albershtein. All rights reserved.
//

import UIKit

class Article {
    var title: String
    var description: String
    var content: String
    let datePublished: Date
    var image: UIImage?
    
    init(_ title: String, _ description: String, _ content: String, _ datePublished: Date) {
            self.title = title
            self.description = description
            self.content = content
            self.datePublished = datePublished
            self.image = nil
        }
}
