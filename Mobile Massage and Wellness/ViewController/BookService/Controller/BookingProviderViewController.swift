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
    var bookingDetail:BookingDetail?

    @IBOutlet weak var collectionView: UICollectionView!
    
  
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstIndexPath = self.getFirstIndexPath() {
            self.bookingDetail?.providerNote  = "\(firstIndexPath.item + 1)"  // Save indexPath.item as String
            self.collectionView.selectItem(at: firstIndexPath, animated: true, scrollPosition: .centeredHorizontally)
            self.collectionView(self.collectionView, didSelectItemAt: firstIndexPath)
            
            print("Saved selected index: \(self.bookingDetail?.providerNote ?? "N/A")")
        }
      
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        bookingDetail?.providerNote = String(indexPath.item + 1)
    }
    
    func getFirstIndexPath() -> IndexPath? {
        let sections = collectionView.numberOfSections
        guard sections > 0 else { return nil }

        let items = collectionView.numberOfItems(inSection: 0)
        return items > 0 ? IndexPath(item: 0, section: 0) : nil
    }
    
}
