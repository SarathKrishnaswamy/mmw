//
//  BookingReportCollectionViewCell.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 23/01/25.
//

import UIKit

class BookingReportCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var providerValueLbl: UILabel!
    @IBOutlet weak var locationValueLbl: UILabel!
    @IBOutlet weak var amountPaidValueLbl: UILabel!
    @IBOutlet weak var createdDateValueLbl: UILabel!
    @IBOutlet weak var statusValueLbl: UILabel!
    @IBOutlet weak var schedulevalueLbl: UILabel!
    @IBOutlet weak var paymentDateValueLbl: UILabel!
    @IBOutlet weak var servicesValueLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        bgView.layer.borderColor = UIColor.text.cgColor
        bgView.layer.borderWidth = 1
        bgView.layer.cornerRadius = 10
    }
    

    
    
}
