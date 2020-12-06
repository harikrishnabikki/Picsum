//
//  ViewController.swift
//  Picsum
//
//  Created by Hari Krishna Bikki on 4/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var picsum = [Picsum]() // Model class Init
    var pageNumber = 1 // Initializing the page Number
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fetching the initial collection view reponse from the Networking service
        NetworkingService.shared.getPicsum { [self] (response) in
            self.picsum = response.picsum
            self.collectionView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Incase if there will be a memory warning the cached images will be removed for optimization.
        imageCache.removeAllObjects()
    }
    
    
}

//MARK:- CollectionView DataSource

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picsum.count // returns the number of cell count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicsumCell", for: indexPath) as? PicsumCell else { return UICollectionViewCell() }
        cell.configure(with: picsum[indexPath.item])
        if (indexPath.row == self.picsum.count-1) { // When user scrolls to the last model value
            self.pageNumber += 1 // self Increment
            if(self.pageNumber <= 10){ // there are only 10 valid pages available
                // Appending data to the Picsum model
                NetworkingService.shared.getPicsum(pageNumber: pageNumber) { (response) in
                    self.picsum.append(contentsOf: response.picsum) // appending the data
                    self.collectionView.reloadData() // reloads the collection view
                }
            }
           
        }
        return cell
    }
}

