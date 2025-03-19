//
//  BookingRootViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 02/01/25.
//

import UIKit

class BookingRootViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, ViewBookingDelegate {
    
    
    
    @IBOutlet weak var containerView: UIView! // Connect this from Storyboard
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    private var pageViewController: UIPageViewController!
    private var viewControllersList: [UIViewController] = []
    private var sideMenuVisible = false
    private let sideMenuWidth: CGFloat = 280
    private var sideMenuVC: MenuTableViewController?
    var bookingDetail = BookingDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the child view controllers for the page view controller
        setupViewControllers()
        nextBtn.layer.cornerRadius = 5
        backBtn.layer.cornerRadius = 5
        // Set initial state of back button
        backBtn.transform = CGAffineTransform(translationX: -backBtn.frame.width, y: 0)
        backBtn.alpha = 0
        backBtn.isHidden = true
        // Initialize and embed the UIPageViewController
        setupPageViewController()
        setupSideMenu()
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
    
    
    
    
    
    // MARK: - Setup View Controllers
    private func setupViewControllers() {
        let storyboard = UIStoryboard(name: "BookService", bundle: nil)
        
        // Add your child view controllers here
        let page1 = storyboard.instantiateViewController(withIdentifier: "BookingDetailViewController") as! BookingDetailViewController
        let page2 = storyboard.instantiateViewController(withIdentifier: "BookingScheduleViewController") as! BookingScheduleViewController
        let page3 = storyboard.instantiateViewController(withIdentifier: "BookingReceiptViewController") as! BookingReceiptViewController
        let page4 = storyboard.instantiateViewController(withIdentifier: "BookingProviderViewController") as! BookingProviderViewController
               
        page1.bookingDetail = bookingDetail
        page2.bookingDetail = bookingDetail
        page3.bookingDetail = bookingDetail
        page4.bookingDetail = bookingDetail
        
        
        viewControllersList = [page1, page2, page3, page4]
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
    
    private func toggleBackButton(hidden: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            if hidden {
                // Slide out to the left (assuming button is on the left)
                self.backBtn.transform = CGAffineTransform(translationX: -self.backBtn.frame.width, y: 0)
                self.backBtn.alpha = 0
            } else {
                // Slide in from the left
                self.backBtn.transform = .identity
                self.backBtn.alpha = 1
            }
        }, completion: { _ in
            self.backBtn.isHidden = hidden
        })
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
            toggleBackButton(hidden: index == 0)
        }
    }
    
    
    @IBAction func backBtnOnPressed(_ sender: Any) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = viewControllersList.firstIndex(of: currentVC),
              currentIndex > 0 else { return }
        
        let previousVC = viewControllersList[currentIndex - 1]
        pageViewController.setViewControllers([previousVC], direction: .reverse, animated: true, completion: { [weak self] completed in
            guard let self = self else { return }
            if completed {
                self.toggleBackButton(hidden: currentIndex - 1 == 0)
            }
        })
    }
    
    
    func didEditBookingDetail(pages:Int) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = viewControllersList.firstIndex(of: currentVC),
              currentIndex > 0 else { return }
        
        let previousVC = viewControllersList[pages]
        pageViewController.setViewControllers([previousVC], direction: .reverse, animated: true, completion: { [weak self] completed in
            guard let self = self else { return }
            if completed {
                self.toggleBackButton(hidden: pages == 0)
            }
        })
    }
    

    @IBAction func nextBtnOnPressed(_ sender: Any) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = viewControllersList.firstIndex(of: currentVC) else { return }
        
        // Perform validation only if on the first page (BookingDetailViewController)
        if let bookingDetailVC = currentVC as? BookingDetailViewController {
            if !bookingDetailVC.validateFields() {
                return // Stop if validation fails
            }
        }
        
        if let bookingScheduleVC = currentVC as? BookingScheduleViewController {
            if !bookingScheduleVC.validateFields() {
                return 
            }
        }
        
        if let bookingReceiptVC = currentVC as? BookingReceiptViewController {
            if !bookingReceiptVC.validateFields() {
                return
            }
        }
        
        if currentIndex < viewControllersList.count - 1 {
            let nextVC = viewControllersList[currentIndex + 1]
            pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: { [weak self] completed in
                guard let self = self else { return }
                if completed {
                    self.toggleBackButton(hidden: false)
                }
            })
        } else {
            navigateToNewPage()
        }
    }

    // MARK: - Navigate to New Page
    private func navigateToNewPage() {
        let storyboard = UIStoryboard(name: "BookService", bundle: nil) // Replace "NewStoryboard" with your storyboard name
        if let viewBookingController = storyboard.instantiateViewController(withIdentifier: "ViewBookingViewController") as? ViewBookingViewController { // Replace with the actual view controller identifier and class
        
            viewBookingController.delegate = self
            viewBookingController.bookingDetail = bookingDetail
            // Present or push the new view controller
            self.navigationController?.pushViewController(viewBookingController, animated: true)
            // OR if not using navigation controller, present it modally
            // self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func menuBtnOnPressed(_ sender: Any) {
        showSideMenu()
        
    }
    
}


// Conform to the delegate protocol
extension BookingRootViewController: SideMenuDelegate {
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
