//
//  ViewController.swift
//  Picsum
//
//  Created by Hari Krishna Bikki on 4/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        NetworkingService.shared.getImgurs { (response) in
//            self.imgurs = response.imgurs
//            self.collectionView.reloadData()
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //imageCache.removeAllObjects()
        
    }
    
    
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicsumCell", for: indexPath) as? PicsumCell else { return UICollectionViewCell() }
        cell.configure()
        return cell
    }


}
