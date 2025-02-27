//
//  NewTicketViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 28/01/25.
//

import UIKit
import IQKeyboardManagerSwift

protocol callbackDelegate: AnyObject {
    func fetchData()
}

class NewTicketViewController: UIViewController {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var prorityView: UIView!
  
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var descTxtView: UITextView!
    @IBOutlet weak var statusTxtView: UITextField!
    @IBOutlet weak var prorityTxtView: UITextField!
    
    @IBOutlet weak var addNewTicketBtn: UIButton!
   
    let placeholderText = "Description" // Placeholder text
    var status = ["Open", "In Progress", "Closed"]
    var priority = ["Low", "Medium", "High"]
    
    private let viewModel = TicketViewModel()
    var delegate: callbackDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descTxtView.delegate = self
        descTxtView.text = placeholderText
        descTxtView.textColor = .lightGray // Placeholder text color
        setupUI()
        setupKeyboardObservers()
        setupBindings()
    }
    
    
    
    func setupUI(){
        titleView.layer.cornerRadius = 5
        statusView.layer.cornerRadius = 5
        prorityView.layer.cornerRadius = 5
        descTxtView.layer.cornerRadius = 5
        addNewTicketBtn.layer.cornerRadius = 5
        self.configureTextField(statusTxtView, with: status)
        self.configureTextField(prorityTxtView, with: priority)
        
    }
    
    private func setupBindings() {
        viewModel.onFetchStoreTickets = { tickets in
            self.dismiss(animated: true) {
                self.delegate?.fetchData()
            }
        }

        viewModel.onFetchStoreTicketsFailure = { error in
            print("Error fetching tickets: \(error)")
        }
        
       
     }
    
    private func setupKeyboardObservers() {
          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
      }

      @objc func keyboardWillShow(_ notification: Notification) {
          if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
              let keyboardHeight = keyboardFrame.height
              self.view.frame.origin.y = -keyboardHeight / 2  // Move view up
          }
      }

      @objc func keyboardWillHide(_ notification: Notification) {
          self.view.frame.origin.y = 0 // Reset position
      }

      deinit {
          NotificationCenter.default.removeObserver(self)
      }
    

    @IBAction func closeBtnOnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addNewTicketBtnOnPressed(_ sender: Any) {
        if self.titleTxtField.text?.isEmpty == true{
            AlertUtils.showAlert(title: "Alert", message: "Please Enter Title", on: self)
        }
        else if self.descTxtView.text?.isEmpty == true || self.descTxtView.text == placeholderText{
            AlertUtils.showAlert(title: "Alert", message: "Please Enter Description", on: self)
        }
        else if self.statusTxtView.text?.isEmpty == true{
            AlertUtils.showAlert(title: "Alert", message: "Please Select Status", on: self)
        }
        else if self.prorityTxtView.text?.isEmpty == true{
            AlertUtils.showAlert(title: "Alert", message: "Please Select Priority", on: self)
        }
        else{
            viewModel.storeTickets(title: titleTxtField.text ?? "", desc: descTxtView.text ?? "", status: statusTxtView.text ?? "", priority: prorityTxtView.text ?? "")
        }
    }
    
    
}

// MARK: - UITextViewDelegate
extension NewTicketViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == placeholderText {
                textView.text = ""
                textView.textColor = .black // Change text color when user starts typing
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                textView.text = placeholderText
                textView.textColor = .lightGray // Restore placeholder color
            }
        }
    
    // Function to Configure TextFields with PickerView
    private func configureTextField(_ textField: UITextField, with data: [String]) {
        textField.delegate = self
        textField.pickerData = data // Assign picker data from extension
        
    }
}
