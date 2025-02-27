//
//  BookingProviderViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 09/01/25.
//

import UIKit

class BookingProviderViewController: UIViewController {
    
    var headerData = ["First Available", "Highly - ranked providers"]
    var descData = ["We will dispatch your booking inquiry to all available service providers in your area.", "Select a provider who has received outstanding ratings from other customers in your area."]

    @IBOutlet weak var collectionView: UICollectionView!
    
  
   
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .top)
    }
    

    

}

extension BookingProviderViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingProviderCollectionViewCell", for: indexPath) as! BookingProviderCollectionViewCell
        cell.headerTxt.text = headerData[indexPath.row]
        cell.subtitleTxt.text = descData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/1.02 // Example: 3 cells per row with spacing
            return CGSize(width: width, height: 92) // Square cells
        }
    
    
}
