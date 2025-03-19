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
    var id: String?
    let viewModel = MyAppointmentsViewModel()
    var addressDetails:AddressResponse?
    var bookingDetails:BookingDetails?
    var scheduleDetails: Schedule?
    var recipient : Recipient?
    var provider : Provider?
    var service : [ServiceResponse]?
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelBookingBtn.layer.cornerRadius = 5
        chatBtn.layer.cornerRadius = 5
        self.viewModel.fetchBookingDetails(id: id ?? "")
        setupUpBindings()
    }
    
    private func setupUpBindings() {
        viewModel.onFetchBookingSuccess = { appointments in
            self.bookingDetails = appointments.booking
            self.addressDetails = appointments.address
            self.scheduleDetails = appointments.schedule
            self.recipient = appointments.recipient
            self.provider = appointments.provider
            self.service = appointments.services
            self.tableView.reloadData()
        }
        
        viewModel.onFetchBookingFailure = { error in
            print("Error fetching appointments: \(error)")
        }
    }
    
    private func setupUpCancel() {
        viewModel.onFetchCancelBookingSuccess = { appointments in
            AlertUtils.showAlert(title: "", message: appointments.message ?? "", on: self) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        viewModel.onFetchCancelBookingFailure = { error in
            print("Error fetching appointments: \(error)")
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func cancelBookingBtnOnPressed(_ sender: Any) {
        let params = [
            "booking_id":"\(self.bookingDetails?.booking_id ?? 0)",
            "booking_order_id":"\(self.bookingDetails?.id ?? 0)"
        ]
        
        self.viewModel.cancelBooking(params: params)
        setupUpCancel()
    }
    
    
    

}

extension MyAppointmentsBookingSummaryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingDetailTableViewCell") as! BookingDetailTableViewCell
            cell.addressValueLbl.text = self.addressDetails?.street_address ?? ""
            cell.sessionValueLbl.text = self.bookingDetails?.session ?? ""
            cell.treatmentValueLbl.text = self.bookingDetails?.treatment ?? ""
            cell.durationValueLbl.text = self.bookingDetails?.duration ?? "" + "Mins"
            if self.bookingDetails?.gender == "no_preference"{
                cell.therapistGenderValueLbl.text = "Therapist Gender : No Preference"
            }
            else{
                cell.therapistGenderValueLbl.text = self.bookingDetails?.gender ?? ""
            }
            return cell
        }
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleDateTimeTableViewCell") as! ScheduleDateTimeTableViewCell
            cell.dateTimeValueLbl.text = (formatDateTimeDayMonth(self.scheduleDetails?.date ?? "") ?? "") + " Between \(self.scheduleDetails?.latest_start_time ?? "") - \(self.scheduleDetails?.earliest_start_time ?? "")"
            cell.bookingFrequencyValueLbl.text = "Booking Frequency : "
            return cell
        }
        else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipientTableViewCell") as! RecipientTableViewCell
            cell.recipientValueLbl.text = "Recipient Name : \(self.recipient?.first_name ?? "")"
            cell.recipientEmailValueLbl.text = "Recipient Email : \(self.recipient?.email ?? "")"
            cell.receipientMobileValueLbl.text = "Recipient Mobile : \(self.recipient?.mobile ?? "")"
            return cell
        }
        else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderTableViewCell") as! ProviderTableViewCell
            if self.provider?.provider == 1{
                cell.providerValueLbl.text = "Highly - ranked providers"
            }
            else{
                cell.providerValueLbl.text = "First Available"
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
            if let service = self.service{
                cell.summaryValueLbl.text = "Service : \(service.first?.name ?? "")"
                cell.sumaryPriceLbl.text = "A$\(service.first?.price ?? 0).00"
                cell.totalDueLbl.text = "A$\(service.first?.price ?? 0).00"
            }
            
            return cell
        }
    }
    
    
}
