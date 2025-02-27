//
//  ForgotPasswordViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 23/02/25.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetPasswordBtn: UIButton!
    private let viewModel = ForgotPasswordViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resetPasswordBtn.layer.cornerRadius = 5
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.onForgotPasswordSuccess = { response in
            AlertUtils.showAlert(title: "Alert", message: response.message ?? "", on: self) {
                self.navigationController?.popViewController(animated: true)
            }
    
                 
         }
        viewModel.onForgotPasswordailure = { error in
            print("Failed: \(error)")
            AlertUtils.showAlert(title: "Alert", message: "Please wait before retrying", on: self)
         }
     }
    
    
    
    @IBAction func sendOtpBtnOnPressed(_ sender: Any) {
        if emailTextField.text?.isEmpty ?? true {
            AlertUtils.showAlert(title: "Alert", message: "Please enter an email address", on: self)
        }
        else if !isValidEmail(emailTextField.text ?? "") {
            AlertUtils.showAlert(title: "Alert", message: "Please enter an valid email", on: self)
        }
        else{
            viewModel.forgotPassword(email: emailTextField.text ?? "")
        }
    }
    
}
