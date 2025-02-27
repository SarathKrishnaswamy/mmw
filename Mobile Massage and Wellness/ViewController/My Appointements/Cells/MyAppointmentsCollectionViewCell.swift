//
//  MyAppointmentsCollectionViewCell.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 11/01/25.
//

import UIKit

class MyAppointmentsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bookingIDValue: UILabel!
    @IBOutlet weak var dateValueLbl: UILabel!
    @IBOutlet weak var addressValueLbl: UILabel!
    @IBOutlet weak var customerValueLbl: UILabel!
    @IBOutlet weak var statusValueLbl: UILabel!
    @IBOutlet weak var mapBtn: UIButton!
    
    
    override func awakeFromNib() {
        self.mapBtn.layer.cornerRadius = 5
        self.mapBtn.layer.borderWidth = 1
        self.mapBtn.layer.borderColor = UIColor.violet.cgColor
        bgView.layer.borderColor = UIColor.text.cgColor
        bgView.layer.borderWidth = 1
        bgView.layer.cornerRadius = 10
        
    }
    
}
