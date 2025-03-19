//
//  ProviderTableViewCell.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 10/01/25.
//

import UIKit

class ProviderTableViewCell: UITableViewCell {

    @IBOutlet weak var providerValueLbl: UILabel!
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
