//
//  PaymentTransactionCollectionViewCell.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 21/01/25.
//

import UIKit

class PaymentTransactionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bookingIDValue: UILabel!
    @IBOutlet weak var scheduleDateValueLbl: UILabel!
    @IBOutlet weak var paymentStatusValueLbl: UILabel!
    @IBOutlet weak var amountValueLbl: UILabel!
    @IBOutlet weak var bookingDateValueLbl: UILabel!
    @IBOutlet weak var paymentDateValueLbl: UILabel!
    @IBOutlet weak var servicesValueLbl: UILabel!
    
    override func awakeFromNib() {
        bgView.layer.borderColor = UIColor.text.cgColor
        bgView.layer.borderWidth = 1
        bgView.layer.cornerRadius = 10
    }
    
}
