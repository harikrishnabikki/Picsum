//
//  PicsumCell.swift
//  Picsum
//
//  Created by Hari Krishna Bikki on 4/12/20.
//

import UIKit

class PicsumCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var author: UILabel!
    
    
    func configure(with picsum: Picsum){
        author.text = picsum.author
        picsum.image { (image) in
            self.imageView.image = image
        }
        
    }
    
    override func prepareForReuse() {
        author.text = nil
        imageView.image = nil
    }
}
