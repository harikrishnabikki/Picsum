//
//  getPicsumResponse.swift
//  Picsum
//
//  Created by Hari Krishna Bikki on 4/12/20.
//

import Foundation


struct GetPicsumResponse {
    
    let picsum: [Picsum]
    
    init(json: JSON) throws {
        guard let data = json["post"] as? [JSON] else { throw MyError.someError } // fetch the root value
        let picsum = data.map{Picsum(json: $0) }.compactMap{$0} // mapping the values to the model
        self.picsum = picsum
    }
}
