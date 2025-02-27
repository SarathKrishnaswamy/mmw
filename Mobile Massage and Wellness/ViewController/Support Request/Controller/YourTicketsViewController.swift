//
//  YourTicketsViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 23/01/25.
//

import UIKit

class YourTicketsViewController: UIViewController, callbackDelegate {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var createTicketBtn: UIButton!
    @IBOutlet weak var itemsNotFoundStackView: UIStackView!
    
    private let viewModel = TicketViewModel()
    
    
    
    private var sideMenuVisible = false
    private let sideMenuWidth: CGFloat = 280
    private var sideMenuVC: MenuTableViewController?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemsNotFoundStackView.isHidden = true
        self.createTicketBtn.layer.cornerRadius = 5
        setupSideMenu()
        setupBindings()

        // Do any additional setup after loading the view.
    }
    
   

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchTickets()
    }
    
    
    private func setupBindings() {
        viewModel.onFetchTicketsSuccess = { tickets in
            if tickets.data?.isEmpty == true{
                self.collectionView.isHidden = true
                self.itemsNotFoundStackView.isHidden = false
            }
            else{
                self.collectionView.isHidden = false
                self.itemsNotFoundStackView.isHidden = true
                self.collectionView.reloadData()
            }
        }

        viewModel.onFetchTicketsFailure = { error in
            print("Error fetching tickets: \(error)")
        }
     }
    
    
    func fetchData() {
        viewModel.fetchTickets()
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
    
    @IBAction func createTicketBtnOnPressed(_ sender: Any) {
        let vc = UIStoryboard(name: "SupportRequest", bundle: nil).instantiateViewController(withIdentifier: "NewTicketViewController") as! NewTicketViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
}

extension YourTicketsViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.ticketData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YourTicketsCollectionViewCell", for: indexPath) as! YourTicketsCollectionViewCell
        cell.idValueLbl.text = "\(self.viewModel.ticketData?[indexPath.row].ticketID ?? 0)"
        cell.titleValueLbl.text = self.viewModel.ticketData?[indexPath.row].title ?? ""
        cell.descValueLbl.text = self.viewModel.ticketData?[indexPath.row].desc ?? ""
        cell.customerValueLbl.text = self.viewModel.ticketData?[indexPath.row].name ?? ""
        cell.statusValueLbl.text = self.viewModel.ticketData?[indexPath.row].status ?? ""
        cell.priorityValueLbl.text = self.viewModel.ticketData?[indexPath.row].priority ?? ""
        return cell
    }
}


// Conform to the delegate protocol
extension YourTicketsViewController: SideMenuDelegate {
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
