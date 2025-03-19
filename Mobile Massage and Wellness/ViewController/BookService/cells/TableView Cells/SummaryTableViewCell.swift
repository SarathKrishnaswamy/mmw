//
//  SummaryTableViewCell.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 10/01/25.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var summaryValueLbl: UILabel!
    @IBOutlet weak var sumaryPriceLbl: UILabel!
    @IBOutlet weak var totalDueLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
