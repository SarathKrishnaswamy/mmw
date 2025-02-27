//
//  SavedLocationViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 11/01/25.
//

import UIKit

class SavedLocationViewController: UIViewController, EditLocationDelegate {
    
    

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addLocationBtn: UIButton!
    @IBOutlet weak var itemsNotFoundStackView: UIStackView!
    
    
    private var sideMenuVisible = false
    private let sideMenuWidth: CGFloat = 280
    private var sideMenuVC: MenuTableViewController?
    private let viewModel = AddressViewModel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLocationBtn.layer.cornerRadius = 5
        itemsNotFoundStackView.isHidden = true
        collectionView.isHidden = true
        //addSwipeGestureToCollectionView()
        setupSideMenu()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchAddressApi()
    }
    
    
    func editLocation() {
        fetchAddressApi()
    }
    
    func deleteLocation() {
        fetchAddressApi()
    }
    
    func fetchAddressApi(){
        viewModel.fetchAddresses()
        setupBindings()
    }
    
    
    private func setupBindings() {
        viewModel.onFetchAddressesSuccess = { tickets in
            if self.viewModel.addressData?.isEmpty == true{
                self.collectionView.isHidden = true
                self.itemsNotFoundStackView.isHidden = false
            }
            else{
                self.collectionView.isHidden = false
                self.itemsNotFoundStackView.isHidden = true
                self.collectionView.reloadData()
            }
        }

        viewModel.onFetchAddressesFailure = { error in
            print("Error fetching tickets: \(error)")
            self.collectionView.isHidden = true
            self.itemsNotFoundStackView.isHidden = false
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
    
    func addSwipeGestureToCollectionView() {
        // Swipe left gesture (for delete)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeLeft.direction = .left
        collectionView.addGestureRecognizer(swipeLeft)
        
        // Swipe right gesture (for edit)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeRight.direction = .right
        collectionView.addGestureRecognizer(swipeRight)
    }

    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: location) {
            if gesture.direction == .left {
                // Handle swipe left for delete
                showDeleteConfirmation(at: indexPath)
            } else if gesture.direction == .right {
                // Handle swipe right for edit
                showEditOptions(at: indexPath)
            }
        }
    }
    
    
    func showDeleteConfirmation(at indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete", message: "Do you want to delete this item?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            
            self.collectionView.deleteItems(at: [indexPath])
        }))
        present(alert, animated: true, completion: nil)
    }

    func showEditOptions(at indexPath: IndexPath) {
        let alert = UIAlertController(title: "Edit", message: "Do you want to edit this item?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            self.editItem(at: indexPath)
        }))
        present(alert, animated: true, completion: nil)
    }

    func editItem(at indexPath: IndexPath) {
        // Implement your edit logic here
        print("Editing item at \(indexPath.row)")
        let vc = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "EditLocationViewController") as! EditLocationViewController
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
        
        //EditLocationViewController
    }
    
    @IBAction func menuBtnOnPressed(_ sender: Any) {
        showSideMenu()
        
    }
    
    @IBAction func addLocationbtnOnPressed(_ sender: Any) {
        let vc = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true)
    }
    


    



}

extension SavedLocationViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.addressData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavedLocationCollectionViewCell", for: indexPath) as! SavedLocationCollectionViewCell
        cell.streetAddressLbl.text = self.viewModel.addressData?[indexPath.row].streetAddress ?? ""
        cell.configureCell(locationType: self.viewModel.addresses[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "EditLocationViewController") as! EditLocationViewController
        vc.id = self.viewModel.addressData?[indexPath.row].id ?? 0
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }

    
   

    func deleteItem(at indexPath: IndexPath) {
        // Update data source and delete the item
        print("Delete item at \(indexPath)")
        // Implement your delete logic here
        // For example, remove the item from your data array and delete the item from the collection view
        // dataArray.remove(at: indexPath.row)
        // collectionView.deleteItems(at: [indexPath])
    }
    
    
}



// Conform to the delegate protocol
extension SavedLocationViewController: SideMenuDelegate {
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
