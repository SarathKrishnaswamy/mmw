//
//  SavedLocationCollectionViewCell.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 11/01/25.
//

import UIKit


class SavedLocationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var streetAddressLbl: UILabel!
    
    var addresses:[String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    

    override func prepareForReuse() {
        super.prepareForReuse()
        addresses = []
        collectionView.reloadData()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.borderColor = UIColor.text.cgColor
        bgView.layer.borderWidth = 1
        bgView.layer.cornerRadius = 10
        
    }
    
    func configureCell(locationType: [String]) {
        addresses = locationType
        self.collectionView.reloadData()
    }
    
    
}

extension SavedLocationCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddressTypeCollectionViewCell", for: indexPath) as! AddressTypeCollectionViewCell
        cell.itemLbl.text = addresses[indexPath.row]
        return cell
        
    }
}
