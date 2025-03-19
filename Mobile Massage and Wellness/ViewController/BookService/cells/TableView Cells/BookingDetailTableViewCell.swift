//
//  BookingDetailTableViewCell.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 10/01/25.
//

import UIKit

class BookingDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var addressValueLbl: UILabel!
    @IBOutlet weak var sessionValueLbl: UILabel!
    @IBOutlet weak var nameValueLbl: UILabel!
    @IBOutlet weak var treatmentValueLbl: UILabel!
    @IBOutlet weak var durationValueLbl: UILabel!
    @IBOutlet weak var therapistGenderValueLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
