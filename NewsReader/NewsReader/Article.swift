//
//  Article.swift
//  NewsReader
//
//  Created by LocaJuli on 13/08/2020.
//  Copyright © 2020 Iuliia Albershtein. All rights reserved.
//

import UIKit

class Article: NSObject, NSCoding {
    
    var title: String
    var descr: String
    var content: String
    let datePublished: Date
    var image: UIImage?
    
    init(_ title: String, _ descr: String, _ content: String, _ datePublished: Date) {
            self.title = title
            self.descr = descr
            self.content = content
            self.datePublished = datePublished
            self.image = nil
        }
    
    func encode(with aCoder: NSCoder) {
            aCoder.encode(title, forKey: "title")
            aCoder.encode(descr, forKey: "description")
            aCoder.encode(content, forKey: "content")
            aCoder.encode(datePublished, forKey: "datePublished")
            aCoder.encode(image, forKey: "image")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let descr = aDecoder.decodeObject(forKey: "description") as! String
        let content = aDecoder.decodeObject(forKey: "content") as! String
        let datePublished = aDecoder.decodeObject(forKey: "datePublished") as! Date
        //let image = aDecoder.decodeObject(forKey: "image") as! UIImage
        self.init(title, descr, content, datePublished)
    }

    

}
