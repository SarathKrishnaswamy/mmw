//
//  BookingProviderCollectionViewCell.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 09/01/25.
//

import UIKit

class BookingProviderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var headerTxt: UILabel!
    @IBOutlet weak var subtitleTxt: UILabel!
    
    override func awakeFromNib() {
        self.bgView.backgroundColor = .bg
        self.bgView.layer.cornerRadius = 5
    }
    
    override var isSelected: Bool {
           didSet {
               // Change the background color based on selection state
               
               if isSelected{
                   self.bgView.backgroundColor = .selectedBg
                   self.bgView.layer.borderWidth = 1
                   self.bgView.layer.borderColor = UIColor.border.cgColor
               }
               else{
                   self.bgView.backgroundColor = .bg
                   self.bgView.layer.borderWidth = 0
               }
               
           }
       }

    
}
