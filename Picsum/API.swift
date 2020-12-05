//
//  API.swift
//  Picsum
//
//  Created by Hari Krishna Bikki on 5/12/20.
//

import Foundation


struct API: Decodable{
    let id: Int?
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let download_url: String
    
}

