//
//  ViewBookingViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 10/01/25.
//

import UIKit

protocol ViewBookingDelegate: AnyObject {
    func didEditBookingDetail(pages:Int)
}

class ViewBookingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var bookingFrequency = ["One Time", "Weekly", "Every 2 weeks", "Every 3 weeks", "Every 4 weeks", "Custom"]
    var headerData = ["First Available", "Highly - ranked providers"]
    var bookingDetail: BookingDetail?
    var delegate: ViewBookingDelegate?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ViewBookingViewController:UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingDetailTableViewCell") as! BookingDetailTableViewCell
            if let booking = bookingDetail {
                cell.addressValueLbl.text = booking.address ?? ""
                cell.sessionValueLbl.text = booking.sessionType ?? ""
                cell.treatmentValueLbl.text = booking.treatmentType ?? ""
                cell.durationValueLbl.text = booking.duration ?? ""
                cell.therapistGenderValueLbl.text = "Therapist Gender : \(booking.therapistGender ?? "")"
                cell.editBtn.tag = 0
                cell.editBtn.addTarget(self, action: #selector(editBtnTapped(_:)), for: .touchUpInside)
            }
          
            return cell
        }
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleDateTimeTableViewCell") as! ScheduleDateTimeTableViewCell
            cell.dateTimeValueLbl.text = (formatDateDayMonth(bookingDetail?.date ?? "") ?? "") + " Between \(bookingDetail?.earliestStartTime ?? "") - \(bookingDetail?.latestStartTime ?? "")"
            
            let bookFrequency = bookingFrequency[safe: (Int(bookingDetail?.bookingFrequency ?? "") ?? 0) - 1] ?? "One Time"
            cell.bookingFrequencyValueLbl.text = "Booking Frequency : \(bookFrequency)"
            cell.editBtn.tag = 1
            cell.editBtn.addTarget(self, action: #selector(editBtnTapped(_:)), for: .touchUpInside)
            return cell
        }
        else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipientTableViewCell") as! RecipientTableViewCell
            cell.recipientValueLbl.text = "Recipient Name : \(bookingDetail?.firstName ?? "") \(bookingDetail?.lastName ?? "")"
            cell.recipientEmailValueLbl.text = "Recipient Email : \(bookingDetail?.email ?? "")"
            cell.receipientMobileValueLbl.text = "Recipient Mobile : \(bookingDetail?.mobileNumber ?? "")"
            cell.editBtn.tag = 2
            cell.editBtn.addTarget(self, action: #selector(editBtnTapped(_:)), for: .touchUpInside)
            return cell
        }
        else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationDetailTableViewCell") as! LocationDetailTableViewCell
            cell.locationTypeValueLbl.text = "Location Type : \(bookingDetail?.locationType ?? "")"
            cell.parkingValueLbl.text = "Parking : \(bookingDetail?.parking ?? "")"
            cell.petsValueLbl.text = "Pets : \(bookingDetail?.pets ?? "")"
            cell.medicalHistoryValueLbl.text = "Medical History : \(bookingDetail?.medicalHistory ?? "")"
            cell.editBtn.tag = 0
            cell.editBtn.addTarget(self, action: #selector(editBtnTapped(_:)), for: .touchUpInside)
            return cell
        }
        else if indexPath.row == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderTableViewCell") as! ProviderTableViewCell
            print(bookingDetail?.providerNote ?? "")
            if bookingDetail?.providerNote ?? "" == "1"{
                cell.providerValueLbl.text = "First Available"
            }
            else{
                cell.providerValueLbl.text = "Highly - ranked providers"
            }
            cell.editBtn.tag = 3
            cell.editBtn.addTarget(self, action: #selector(editBtnTapped(_:)), for: .touchUpInside)
            return cell
        }
        else if indexPath.row == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoteForTherapistTableViewCell") as! NoteForTherapistTableViewCell
            cell.noteLbl.text = bookingDetail?.therapistNote ?? ""
            cell.editBtn.tag = 2
            cell.editBtn.addTarget(self, action: #selector(editBtnTapped(_:)), for: .touchUpInside)
            return cell
        }
        else if indexPath.row == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
            cell.summaryValueLbl.text = "Service : \(bookingDetail?.treatmentType ?? "")"
            cell.sumaryPriceLbl.text = "A$\(bookingDetail?.price ?? "")"
            cell.totalDueLbl.text = "A$\(bookingDetail?.price ?? "")"
            return cell
        }
        
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestBookTableViewCell") as! RequestBookTableViewCell
            return cell
        }
    }
    
    @objc func editBtnTapped(_ sender: UIButton){
        delegate?.didEditBookingDetail(pages: sender.tag)
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
