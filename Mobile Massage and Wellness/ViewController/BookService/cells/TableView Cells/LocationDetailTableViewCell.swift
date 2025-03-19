//
//  LocationDetailTableViewCell.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 10/01/25.
//

import UIKit

class LocationDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var locationTypeValueLbl: UILabel!
    @IBOutlet weak var parkingValueLbl: UILabel!
    @IBOutlet weak var petsValueLbl: UILabel!
    @IBOutlet weak var medicalHistoryValueLbl: UILabel!
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
