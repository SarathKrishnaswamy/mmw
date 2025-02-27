//
//  MenuTableViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 03/01/25.
//

import UIKit
import SideMenu

protocol SideMenuDelegate: AnyObject {
    func didSelectMenuItem(indexPath: Int)
}


class MenuTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: SideMenuDelegate?
    var menuItems = ["Book a Service", "My Appointments", "Saved Locations", "Payment History", "Booking History", "My Profile", "Support Requests"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
                
    }
    
    @IBAction func closeBtnOnPressed(_ sender: Any) {
        delegate?.didSelectMenuItem(indexPath: -1)
    }
    
    @IBAction func signOutBtnOnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            SessionManger.shared.clearAll()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: loginVC)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
}

extension MenuTableViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.menuTitleLbl.text = menuItems[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        delegate?.didSelectMenuItem(indexPath: indexPath.row)
    }
    
    
}

