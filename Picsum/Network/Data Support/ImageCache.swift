//
//  ImageCache.swift
//  Picsum
//
//  Created by Hari Krishna Bikki on 6/12/20.
//

import UIKit

let imageCache = ImageCache()

class ImageCache: NSCache<AnyObject, AnyObject> {
    // Save image like dict. Save image for a specified key and later on use the key to access the value
    func add(_ image: UIImage, forKey key: String) {
        setObject(image, forKey: key as AnyObject)
    }
    
    func image(forKey key: String) -> UIImage? {
        guard let image = object(forKey: key as AnyObject) as? UIImage else { return nil }
        return image // if valid return image
    }
}
