//
//  PaymentTransactionViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 21/01/25.
//

import UIKit

class PaymentTransactionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noItemsFoundStackView: UIStackView!
    
    
    private var sideMenuVisible = false
    private let sideMenuWidth: CGFloat = 280
    private var sideMenuVC: MenuTableViewController?
    private let viewModel = PaymentHistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        self.noItemsFoundStackView.isHidden = true
        self.collectionView.isHidden = true
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    private func setupBindings() {
        viewModel.onFetchPaymentHistorySuccess = { payments in
            if payments.data?.paymentHistories?.isEmpty == true{
                self.collectionView.isHidden = true
                self.noItemsFoundStackView.isHidden = false
            }
            else{
                self.collectionView.isHidden = false
                self.noItemsFoundStackView.isHidden = true
                self.collectionView.reloadData()
            }
        }

        viewModel.onFetchPaymentsHistoryFailure = { error in
            print("Error fetching tickets: \(error)")
            self.collectionView.isHidden = true
            self.noItemsFoundStackView.isHidden = false
            
        }
     }
    
    
    func fetchData() {
        viewModel.fetchPaymentHistory()
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
    


}

extension PaymentTransactionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.paymentData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentTransactionCollectionViewCell", for: indexPath) as! PaymentTransactionCollectionViewCell
        cell.bookingIDValue.text = "\(self.viewModel.paymentData?[indexPath.row].bookingID ?? 0)"
        cell.scheduleDateValueLbl.text = formatDateTime(self.viewModel.paymentData?[indexPath.row].date ?? "")
        if let paymentmode = self.viewModel.paymentData?[indexPath.row].paymentMethods {
            cell.paymentStatusValueLbl.text = "Paid"
            cell.paymentStatusValueLbl.textColor = .success
            cell.amountValueLbl.text = "A$\(self.viewModel.paymentData?[indexPath.row].totalAmount ?? 0) / Paid(Stripe)"
            
        }
        else{
            cell.paymentStatusValueLbl.text = "Pending Payment"
            cell.paymentStatusValueLbl.textColor = .warning
            cell.amountValueLbl.text = "A$\(self.viewModel.paymentData?[indexPath.row].totalAmount ?? 0) / Pending Payment"
            
        }
        cell.bookingDateValueLbl.text = self.viewModel.paymentData?[indexPath.row].bookingDate ?? ""
        cell.paymentDateValueLbl.text = convertToDateOnly(self.viewModel.paymentData?[indexPath.row].paymentDate ?? "")
        cell.servicesValueLbl.text = "\(self.viewModel.paymentData?[indexPath.row].session ?? "") \n \(self.viewModel.paymentData?[indexPath.row].treatment ?? "") \n \(self.viewModel.paymentData?[indexPath.row].duration ?? "") Mins"
        
        return cell
    }
    
    
}


extension PaymentTransactionViewController: SideMenuDelegate {
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
