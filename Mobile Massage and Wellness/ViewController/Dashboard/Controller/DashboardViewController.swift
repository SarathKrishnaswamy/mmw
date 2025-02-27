//
//  DashboardViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 25/12/24.
//

import UIKit
import SideMenu



class DashboardViewController: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    @IBOutlet weak var view9: UIView!
    @IBOutlet weak var view10: UIView!
    @IBOutlet weak var view11: UIView!
    
    @IBOutlet weak var bookingsCompletedLbl: UILabel!
    @IBOutlet weak var notAssigedToProviderLbl: UILabel!
    @IBOutlet weak var providerApprovalLbl: UILabel!
    @IBOutlet weak var rescheduleApprovalLbl: UILabel!
    @IBOutlet weak var bookingConfirmedLbl: UILabel!
    @IBOutlet weak var bookingCancelledLbl: UILabel!
    @IBOutlet weak var bookingPayoutLbl: UILabel!
    @IBOutlet weak var clientCancelBookingLbl: UILabel!
    @IBOutlet weak var serviceProviderLbl: UILabel!
    @IBOutlet weak var timeoutCancelBookingLbl: UILabel!
    @IBOutlet weak var noClientCancelBookingLbl: UILabel!
    
    
    
    
    
    
    private var sideMenuVisible = false
    private let sideMenuWidth: CGFloat = 280
    private var sideMenuVC: MenuTableViewController?
    private let viewModel = DashboardViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupSideMenu()
        addGestures()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.fetchDashboardData()
    }
    
    private func setupBindings(){
        viewModel.onDashboardDataSuccess = { response in
            print(response)
            self.bookingsCompletedLbl.text = "\(response.data?.completedBookings ?? 0)"
            self.notAssigedToProviderLbl.text = "\(response.data?.notAssignedBookings ?? 0)"
            self.providerApprovalLbl.text = "\(response.data?.waitingForApproval ?? 0)"
            self.rescheduleApprovalLbl.text = "\(response.data?.waitingForRescheduleApproval ?? 0)"
            self.bookingConfirmedLbl.text = "\(response.data?.confirmedBookings ?? 0)"
            self.bookingCancelledLbl.text = "\(response.data?.cancelledBookings ?? 0)"
            self.bookingPayoutLbl.text = "\(response.data?.payoutBooking ?? 0)"
            self.clientCancelBookingLbl.text = "\(response.data?.clientCancelBooking ?? 0)"
            self.serviceProviderLbl.text = "\(response.data?.serviceProviderCancelBooking ?? 0)"
            self.timeoutCancelBookingLbl.text = "\(response.data?.timeOutCancelBooking ?? 0)"
            self.noClientCancelBookingLbl.text = "\(response.data?.noClientCancelBooking ?? 0)"
            
        }
        viewModel.onDashboardDataFailure = { error in
            print("Failed: \(error)")
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
    
    func setupViews(){
        view1.layer.cornerRadius = 14
        view2.layer.cornerRadius = 14
        view3.layer.cornerRadius = 14
        view4.layer.cornerRadius = 14
        view5.layer.cornerRadius = 14
        view6.layer.cornerRadius = 14
        view7.layer.cornerRadius = 14
        view8.layer.cornerRadius = 14
        view9.layer.cornerRadius = 14
        view10.layer.cornerRadius = 14
        view11.layer.cornerRadius = 14
    }
    
    @IBAction func menuBtnOnPressed(_ sender: Any) {
        showSideMenu()
        
    }
    
}


// Conform to the delegate protocol
extension DashboardViewController: SideMenuDelegate {
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
