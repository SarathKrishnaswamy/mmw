//
//  MyProfileRootViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 29/01/25.
//

import UIKit
import MXSegmentedControl

class MyProfileRootViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    @IBOutlet weak var segmentedControl: MXSegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    private var pageViewController: UIPageViewController!
    private var viewControllersList: [UIViewController] = []
    private var sideMenuVisible = false
    private let sideMenuWidth: CGFloat = 280
    private var sideMenuVC: MenuTableViewController?
    var segmentMenu = ["PROFILE", "BUSINESS", "PREFERENCE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        for item in segmentMenu {
            self.segmentedControl.append(title: item)
        }
        segmentedControl.addTarget(self, action: #selector(changeIndex(segmentedControl:)), for: .valueChanged)
        setupViewControllers()
        setupPageViewController()
        
    }
    
    // MARK: - Setup View Controllers
    private func setupViewControllers() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        
        // Add your child view controllers here
        
        let page1 = storyboard.instantiateViewController(withIdentifier: "ProfileDataViewController")
        let page2 = storyboard.instantiateViewController(withIdentifier: "BusinessDataViewController")
        let page3 = storyboard.instantiateViewController(withIdentifier: "PreferenceDataViewController")
        
        
        
        viewControllersList = [page1, page2,page3]
    }
    
    @objc func changeIndex(segmentedControl: MXSegmentedControl) {
        let selectedIndex = segmentedControl.selectedIndex
        guard selectedIndex < viewControllersList.count else { return }
        
        // Set the corresponding view controller
        let selectedViewController = viewControllersList[selectedIndex]
        
        // Determine the navigation direction
        let direction: UIPageViewController.NavigationDirection = selectedIndex > (pageViewController.viewControllers?.first.flatMap { viewControllersList.firstIndex(of: $0) } ?? 0) ? .forward : .reverse
        
        pageViewController.setViewControllers([selectedViewController], direction: direction, animated: true) { completed in
            if completed {
                // Ensure the API call happens when view appears
                if let vc = selectedViewController as? UIViewController {
                    vc.viewWillAppear(true)
                }
            }
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
    
   
    
    // MARK: - Setup PageViewController
    private func setupPageViewController() {
        // Initialize UIPageViewController
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        // Set the initial page
        if let firstVC = viewControllersList.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        // Add UIPageViewController as a child
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        // Constrain the page view controller's view to the container view
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllersList.firstIndex(of: viewController), index > 0 else { return nil }
        return viewControllersList[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllersList.firstIndex(of: viewController), index < viewControllersList.count - 1 else { return nil }
        return viewControllersList[index + 1]
    }
    
    // MARK: - UIPageViewControllerDelegate
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let currentVC = pageViewController.viewControllers?.first, let index = viewControllersList.firstIndex(of: currentVC) {
            // Toggle the back button with animation
            if index == 0 {
                segmentedControl.select(index: 0, animated: true)
            }
            else if index == 1 {
                segmentedControl.select(index: 1, animated: true)
            }
            else{
                segmentedControl.select(index: 2, animated: true)
            }
        
        }
    }
    
    @IBAction func menuBtnOnPressed(_ sender: Any) {
        showSideMenu()
        
    }

}

// Conform to the delegate protocol
extension MyProfileRootViewController: SideMenuDelegate {
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
