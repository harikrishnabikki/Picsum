//
//  ViewController.swift
//  Picsum
//
//  Created by Hari Krishna Bikki on 4/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var picsum = [Picsum]()
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print("updated:", pageNumber)

        
        NetworkingService.shared.getPicsum { [self] (response) in
            self.picsum = response.picsum
            self.collectionView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        imageCache.removeAllObjects()
    }
    
    
}

//MARK:- CollectionView DataSource

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picsum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicsumCell", for: indexPath) as? PicsumCell else { return UICollectionViewCell() }
        cell.configure(with: picsum[indexPath.item])
        if (indexPath.row == self.picsum.count-1) {
            self.pageNumber += 1
            if(self.pageNumber <= 10){
                NetworkingService.shared.getPicsum(pageNumber: pageNumber, shouldPage: true) { (response) in
                    self.picsum.append(contentsOf: response.picsum)
                    self.collectionView.reloadData()
                }
            }
           
        }
        return cell
    }
}

