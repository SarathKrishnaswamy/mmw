//
//  MyAppointmentsBookingSummaryViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 11/01/25.
//

import UIKit

class MyAppointmentsBookingSummaryViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelBookingBtn: UIButton!
    @IBOutlet weak var chatBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelBookingBtn.layer.cornerRadius = 5
        chatBtn.layer.cornerRadius = 5
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension MyAppointmentsBookingSummaryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingDetailTableViewCell") as! BookingDetailTableViewCell
            return cell
        }
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleDateTimeTableViewCell") as! ScheduleDateTimeTableViewCell
            return cell
        }
        else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipientTableViewCell") as! RecipientTableViewCell
            return cell
        }
        else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderTableViewCell") as! ProviderTableViewCell
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
            return cell
        }
    }
    
    
}
