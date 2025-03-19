//
//  MyAppointmentsViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 11/01/25.
//

import UIKit

class MyAppointmentsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectionSegmentViewController: UISegmentedControl!
    @IBOutlet weak var itemsNotFoundStackView: UIStackView!
    
    private var sideMenuVisible = false
    private let sideMenuWidth: CGFloat = 280
    private var sideMenuVC: MenuTableViewController?
    let viewModel = MyAppointmentsViewModel()
    var upcomingBookings: [Booking]?
    var previousBookings: [Booking]?
    var isUpcomingSelected: Bool = false
    var isPreviousSelected: Bool = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeSegmentedControl()
        setupSideMenu()
        self.viewModel.fetchAppointments()
        setupUpComingBoookings()
        
    }
    
    private func setupUpComingBoookings() {
        self.isUpcomingSelected = true
        self.isPreviousSelected = false
        viewModel.onFetchAppointmentsSuccess = { appointments in
            self.upcomingBookings = appointments.data?.upcomingBookings ?? []
            if !(self.upcomingBookings?.isEmpty ?? false) {
                self.collectionView.isHidden = false
                self.itemsNotFoundStackView.isHidden = true
            }
            else{
                self.collectionView.isHidden = true
                self.itemsNotFoundStackView.isHidden = false
            }
            //self.previousBookings = appointments.data?.previousBookings ?? []
            self.collectionView.reloadData()
        }
        
        viewModel.onFetchAppointmentsFailure = { error in
            print("Error fetching appointments: \(error)")
        }
    }
    
    
    private func setupUpPreviousBookings() {
        self.isUpcomingSelected = false
        self.isPreviousSelected = true
        viewModel.onFetchAppointmentsSuccess = { appointments in
            self.previousBookings = appointments.data?.previousBookings ?? []
            if !(self.previousBookings?.isEmpty ?? false) {
                self.collectionView.isHidden = false
                self.itemsNotFoundStackView.isHidden = true
            }
            else{
                self.collectionView.isHidden = true
                self.itemsNotFoundStackView.isHidden = false
            }
            self.collectionView.reloadData()
        }
        
        viewModel.onFetchAppointmentsFailure = { error in
            print("Error fetching appointments: \(error)")
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
    
    
    private func customizeSegmentedControl() {
            // Set normal state attributes
            let normalAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.text, // Text color for unselected state
                .font: UIFont.systemFont(ofSize: 14, weight: .medium)
            ]
            selectionSegmentViewController.setTitleTextAttributes(normalAttributes, for: .normal)

            // Set selected state attributes
            let selectedAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white, // Text color for selected state
                .font: UIFont.systemFont(ofSize: 14, weight: .bold)
            ]
            selectionSegmentViewController.setTitleTextAttributes(selectedAttributes, for: .selected)

            // Set background colors
            //selectionSegmentViewController.selectedSegmentTintColor = UIColor.blue
        }
    
    
    @IBAction func segmentControlonPressed(_ sender: Any) {
        if selectionSegmentViewController.selectedSegmentIndex == 0 {
            self.viewModel.fetchAppointments()
            self.setupUpComingBoookings()
        }
        else{
            self.viewModel.fetchAppointments()
            self.setupUpPreviousBookings()
        }
    }
    
    
    @IBAction func menuBtnOnPressed(_ sender: Any) {
        showSideMenu()
        
    }
    
       
}

extension MyAppointmentsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isUpcomingSelected {
            return upcomingBookings?.count ?? 0
        }
        else{
            return previousBookings?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyAppointmentsCollectionViewCell", for: indexPath) as! MyAppointmentsCollectionViewCell
        if isUpcomingSelected{
            cell.bookingIDValue.text = String(self.upcomingBookings?[indexPath.row].bookingID ?? 0)
            cell.dateValueLbl.text =  formatDateTimeNoAMPM(self.upcomingBookings?[indexPath.row].bookingDate ?? "")
            cell.addressValueLbl.text = self.upcomingBookings?[indexPath.row].streetAddress ?? ""
            cell.customerValueLbl.text = self.upcomingBookings?[indexPath.row].name ?? ""
            cell.statusValueLbl.text = BookingStatusResponse(rawValue: self.upcomingBookings?[indexPath.row].acceptStatus ?? 0)?.description ?? "Unknown Status"
            let status = BookingStatusResponse(rawValue: self.upcomingBookings?[indexPath.row].acceptStatus ?? 0)?.color
            cell.statusValueLbl.textColor = status
            
            
            cell.mapBtn.addTarget(self, action: #selector(openMap(sender:)), for: .touchUpInside)
            cell.mapBtn.tag = indexPath.row
        }
        else{
            cell.bookingIDValue.text = String(self.previousBookings?[indexPath.row].bookingID ?? 0)
            cell.dateValueLbl.text =  formatDateTimeNoAMPM(self.previousBookings?[indexPath.row].bookingDate ?? "")
            cell.addressValueLbl.text = self.previousBookings?[indexPath.row].streetAddress ?? ""
            cell.customerValueLbl.text = self.previousBookings?[indexPath.row].name ?? ""
            cell.statusValueLbl.text = BookingStatusResponse(rawValue: self.previousBookings?[indexPath.row].acceptStatus ?? 0)?.description ?? "Unknown Status"
            let status = BookingStatusResponse(rawValue: self.previousBookings?[indexPath.row].acceptStatus ?? 0)?.color
            cell.statusValueLbl.textColor = status
            cell.mapBtn.addTarget(self, action: #selector(openMap(sender:)), for: .touchUpInside)
            cell.mapBtn.tag = indexPath.row
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "MyAppointments", bundle: nil).instantiateViewController(withIdentifier: "MyAppointmentsBookingSummaryViewController") as! MyAppointmentsBookingSummaryViewController
        if isUpcomingSelected{
            vc.id = String(self.upcomingBookings?[indexPath.item].id ?? 0)
        }
        else{
            vc.id = String(self.previousBookings?[indexPath.item].id ?? 0)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openMap(sender:UIButton){
        let tag = sender.tag
        let indexPath = IndexPath(item: tag, section: 0)
        if isUpcomingSelected{
            if let lat = self.upcomingBookings?[indexPath.item].latitude, let lon = self.upcomingBookings?[indexPath.item].longitude,
               let latitude = Double(lat), let longitude = Double(lon) {
                let googleMapsWebURL = URL(string: "https://www.google.com/maps?q=\(latitude),\(longitude)")!
                UIApplication.shared.open(googleMapsWebURL)
            }
        }
        else{
            if let lat = self.previousBookings?[indexPath.item].latitude, let lon = self.previousBookings?[indexPath.item].longitude,
               let latitude = Double(lat), let longitude = Double(lon) {
                let googleMapsURL = URL(string: "comgooglemaps://?q=\(latitude),\(longitude)")!
                
                if UIApplication.shared.canOpenURL(googleMapsURL) {
                    UIApplication.shared.open(googleMapsURL)
                } else {
                    // Fallback to Apple Maps if Google Maps is not installed
                    let appleMapsURL = URL(string: "http://maps.apple.com/?ll=\(latitude),\(longitude)")!
                    UIApplication.shared.open(appleMapsURL)
                }
            }
        }
        
    }
    
    
    
}


extension MyAppointmentsViewController: SideMenuDelegate {
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
