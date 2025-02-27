//
//  RequestBookTableViewCell.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 10/01/25.
//

import UIKit

class RequestBookTableViewCell: UITableViewCell {

    @IBOutlet weak var requestBookBtn: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        requestBookBtn.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
