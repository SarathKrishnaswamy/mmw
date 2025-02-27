//
//  VerifyOTPViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 22/02/25.
//

import UIKit
import AEOTPTextField

protocol VerifyOTPDelegate: AnyObject {
    func didMobileVerifyOTP(isMobileVerified:Bool)
    func didEmailVerifyOTP(isEmailVerified:Bool)
}

class VerifyOTPViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var otpTextField: AEOTPTextField!
    @IBOutlet weak var verifyOTPButton: UIButton!
    private let viewModel = VerifyOTPViewModel()
    
    var isEmailVerified: Bool = false
    var isMobileVerified: Bool = false
    var email:String = ""
    var mobile:String = ""
    var countryCode:String = ""
    var delegate:VerifyOTPDelegate?
    var mobileOTP:Int = 0
    var emailOTP:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.layer.cornerRadius = 5
        verifyOTPButton.layer.cornerRadius = 5
        otpTextField.otpDelegate = self
        otpTextField.configure(with: 6)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(tapGesture)
        if isEmailVerified{
            viewModel.verifyEmailOTP(email: email)
        }
        else{
            viewModel.verifyMobileOTP(countryCode: countryCode, phoneNumber: mobile)
        }
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.onMobileOTPSuccess = { response in
            print("Phone OTP Verified")
            self.mobileOTP = response.otp ?? 123456
         }
        
        viewModel.onEmailOTPSuccess = { response in
            print("Email OTP Verified")
            self.emailOTP = response.otp ?? 123456
            
        }
        viewModel.onOTPFailure = { error in
             print("Login Failed: \(error)")
         }
     }
    
    // Dismiss view
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func verifyOTPTextField(_ sender: Any) {
        if isEmailVerified && Int(otpTextField.text ?? "") == emailOTP{
            self.dismiss(animated: true) {
                self.delegate?.didEmailVerifyOTP(isEmailVerified: true)
            }
        }
        else if isMobileVerified && Int(otpTextField.text ?? "") == mobileOTP{
            self.dismiss(animated: true) {
                self.delegate?.didMobileVerifyOTP(isMobileVerified: true)
            }
        }
        
    }
    
}

extension VerifyOTPViewController: AEOTPTextFieldDelegate {
    func didUserFinishEnter(the code: String) {
        print(code)
    }
    
    func otpTextFieldDidChange(_ textField: AEOTPTextField) {
        print("OTP: \(textField.text ?? "")")
    }
}
