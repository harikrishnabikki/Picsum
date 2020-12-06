//
//  Picsum.swift
//  Picsum
//
//  Created by Hari Krishna Bikki on 5/12/20.
//

import UIKit

struct Picsum {
    
    private let id: String
    private let download_url: String
    
    let author: String
    let width: Int
    let height: Int
    let url: String
   
    
    init?(json:JSON){
        guard let id = json["id"] as? String,
            let author = json["author"] as? String,
            let width = json["width"] as? Int,
            let height = json["height"] as? Int,
            let url =  json["url"] as? String,
            let download_url =  json["download_url"] as? String
            else{return nil}
        
        self.id = id
        self.author  = author
        self.width = width
        self.height = height
        self.url = url
        self.download_url = download_url
        
    }
}
