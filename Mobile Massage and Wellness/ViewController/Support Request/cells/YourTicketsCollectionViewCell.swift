//
//  YourTicketsCollectionViewCell.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 23/01/25.
//

import UIKit

class YourTicketsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var idValueLbl: UILabel!
    @IBOutlet weak var titleValueLbl: UILabel!
    @IBOutlet weak var descValueLbl: UILabel!
    @IBOutlet weak var customerValueLbl: UILabel!
    @IBOutlet weak var statusValueLbl: UILabel!
    @IBOutlet weak var priorityValueLbl: UILabel!
    
    override func awakeFromNib() {
        bgView.layer.borderColor = UIColor.text.cgColor
        bgView.layer.borderWidth = 1
        bgView.layer.cornerRadius = 10
    }
    
}
