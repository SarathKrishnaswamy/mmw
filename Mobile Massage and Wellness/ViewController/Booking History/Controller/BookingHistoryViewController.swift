//
//  BookinHistoryViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 21/01/25.
//

import UIKit

class BookingHistoryViewController: UIViewController {

    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var itemsNotFoundStackView: UIStackView!
    
    private var sideMenuVisible = false
    private let sideMenuWidth: CGFloat = 280
    private var sideMenuVC: MenuTableViewController?
    
    private let viewModel = BookingReportViewModel()
    var model: BookingHistoryModel?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterBtn.layer.cornerRadius = 5
        self.collectionView.isHidden = true
        self.itemsNotFoundStackView.isHidden = true
        setupSideMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.fetchBookings()
        setupBindings()
    }
    
    
    private func setupBindings() {
        viewModel.onFetchBookingsSuccess = { bookingReport in
            if self.viewModel.bookings.isEmpty == true {
                self.collectionView.isHidden = true
                self.filterBtn.isHidden = true
                self.itemsNotFoundStackView.isHidden = false
            }
            else{
                self.collectionView.isHidden = false
                self.filterBtn.isHidden = false
                self.itemsNotFoundStackView.isHidden = true
                self.collectionView.reloadData()
                self.model = bookingReport
            }
        }

        viewModel.onFetchBookingsFailure = { error in
            print("Error fetching tickets: \(error)")
        }
        
       
     }
    
    private func setupSideMenu() {
        guard let sideMenuVC = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "MenuTableViewController") as? MenuTableViewController else { return }
        self.sideMenuVC = sideMenuVC
        sideMenuVC.delegate = self
        addChild(sideMenuVC)
        view.addSubview(sideMenuVC.view)
        
        // Set initial position of the side menu
        sideMenuVC.view.frame = CGRect(x: -sideMenuWidth, y: 0, width: sideMenuWidth, height: view.frame.height)
        sideMenuVC.didMove(toParent: self)
    }
    
    private func addGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view).x
        
        if gesture.state == .changed {
            if translation > 0 && !sideMenuVisible { // Open menu
                sideMenuVC?.view.frame.origin.x = min(translation - sideMenuWidth, 0)
            } else if sideMenuVisible { // Close menu
                sideMenuVC?.view.frame.origin.x = min(0, translation)
            }
        } else if gesture.state == .ended {
            if translation > sideMenuWidth / 2 {
                showSideMenu()
            } else {
                hideSideMenu()
            }
        }
    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        if sideMenuVisible {
            hideSideMenu()
        }
    }
    
    private func showSideMenu() {
        UIView.animate(withDuration: 0.3) {
            self.sideMenuVC?.view.frame.origin.x = 0
        }
        sideMenuVisible = true
    }
    
    private func hideSideMenu() {
        UIView.animate(withDuration: 0.3) {
            self.sideMenuVC?.view.frame.origin.x = -self.sideMenuWidth
        }
        sideMenuVisible = false
    }
    
    @IBAction func menuBtnOnPressed(_ sender: Any) {
        showSideMenu()
        
    }
    
    @IBAction func filterBtnOnPressed(_ sender: Any) {
        let vc = UIStoryboard(name: "BookingHistory", bundle: nil).instantiateViewController(withIdentifier: "FilterBookinHistoryViewController") as! FilterBookinHistoryViewController
        vc.model = self.model
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    

}

extension BookingHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.bookings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingReportCollectionViewCell", for: indexPath) as! BookingReportCollectionViewCell
        cell.providerValueLbl.text = "\(self.viewModel.bookings[indexPath.row].provider_name ?? "") \n \(self.viewModel.bookings[indexPath.row].mobile_number ?? "") \n \(self.viewModel.bookings[indexPath.row].email ?? "")"
        cell.locationValueLbl.text = self.viewModel.bookings[indexPath.row].location ?? ""
        cell.amountPaidValueLbl.text = "A$\(self.viewModel.bookings[indexPath.row].total_amount ?? 0) / Paid(Stripe)"
        cell.createdDateValueLbl.text = self.viewModel.bookings[indexPath.row].created_at ?? ""
        cell.schedulevalueLbl.text = formatDateTime(self.viewModel.bookings[indexPath.row].schedule_date ?? "")
        cell.paymentDateValueLbl.text = formatDateTime(self.viewModel.bookings[indexPath.row].payment_date ?? "")
        cell.servicesValueLbl.text = "\(self.viewModel.bookings[indexPath.row].session ?? "")\n\(self.viewModel.bookings[indexPath.row].treatment ?? "")\n\(self.viewModel.bookings[indexPath.row].duration ?? "") Mins"
        
        cell.statusValueLbl.text = "Completed"
        return cell
    }
}

// Conform to the delegate protocol
extension BookingHistoryViewController: SideMenuDelegate {
    func didSelectMenuItem(indexPath: Int) {
        hideSideMenu()
        if indexPath == 0 {
            print(indexPath)
            let vc = UIStoryboard(name: "BookService", bundle: nil).instantiateViewController(withIdentifier: "BookingRootViewController") as! BookingRootViewController
            self.navigationController?.pushViewController(vc, animated: true)

        }
        else if indexPath == 1 {
            let vc = UIStoryboard(name: "MyAppointments", bundle: nil).instantiateViewController(withIdentifier: "MyAppointmentsViewController") as! MyAppointmentsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath == 2 {
            let vc = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "SavedLocationViewController") as! SavedLocationViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath == 3 {
            let vc = UIStoryboard(name: "PaymentHistory", bundle: nil).instantiateViewController(withIdentifier: "PaymentTransactionViewController") as! PaymentTransactionViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath == 4 {
            let vc = UIStoryboard(name: "BookingHistory", bundle: nil).instantiateViewController(withIdentifier: "BookingHistoryViewController") as! BookingHistoryViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath == 5 {
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "MyProfileRootViewController") as! MyProfileRootViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath == 6 {
            let vc = UIStoryboard(name: "SupportRequest", bundle: nil).instantiateViewController(withIdentifier: "YourTicketsViewController") as! YourTicketsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
        
    }
}
