//
//  UrlImageView.swift
//  NewsReader
//
//  Created by LocaJuli on 12/10/2020.
//  Copyright © 2020 Iuliia Albershtein. All rights reserved.
//

import UIKit

class UrlImageView: UIImageView {
    
    var url: URL! {
        didSet {
            download(url)
        }
    }
    
    private func download(_ url: URL) {
        guard let url = self.url else { return }
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            guard let response = response as? HTTPURLResponse else { return }
            guard let data = data, response.statusCode == 200 else {
                if let error = error {
                    print("Invalid url response: \(error.localizedDescription)")
                } else {
                    print("Invalid url response: \(response.statusCode)")
                }
                return
            }
            
            DispatchQueue.main.async {
                if self.url == url {
                    self.image = UIImage(data: data)
                }
            }
        })
        
        task.resume()
    }
}
