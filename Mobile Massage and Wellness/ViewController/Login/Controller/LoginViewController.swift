//
//  ViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 20/12/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    private let viewModel = LoginViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    //Setup UI
    func setupUI(){
        signinBtn.layer.cornerRadius = 5
        signupBtn.layer.cornerRadius = 5
        addEyeIconToTextField(passwordTextField)
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.onLoginSuccess = { response in
            print("Login Successful")
            print(response)
            SessionManger.shared.save(value: true, forKey: .isLoggedIn)
            let vc = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            self.navigationController?.pushViewController(vc, animated: true)
                 
         }
         viewModel.onLoginFailure = { error in
             print("Login Failed: \(error)")
         }
     }

    @IBAction func signinBtnOnPressed(_ sender: Any) {
        if emailTextField.text?.isEmpty ?? true {
            AlertUtils.showAlert(title: "Alert", message: "Please enter an email address", on: self)
        }
        else{
            if !isValidEmail(emailTextField.text ?? ""){
                AlertUtils.showAlert(title: "Alert", message: "Please enter an valid email", on: self)
            }
            else if passwordTextField.text?.isEmpty ?? true {
                AlertUtils.showAlert(title: "Alert", message: "Please enter a password", on: self)
            }
            else{
                viewModel.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "")
            }
        }
    }
    
    
    @IBAction func signupBtnOnPressed(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func forgotPasswordBtnOnPressed(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func addEyeIconToTextField(_ textField: UITextField) {
        // Create a container view to hold the eye icon and add padding
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 30)) // Adjust width for spacing
        
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal) // Default hidden
        eyeButton.tintColor = .gray
        eyeButton.frame = CGRect(x: 10, y: 0, width: 30, height: 30) // Adds 10pt padding from right side
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        
        containerView.addSubview(eyeButton)
        
        textField.rightView = containerView
        textField.rightViewMode = .always
    }

    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        guard let textField = sender.superview?.superview as? UITextField else { return }
        
        textField.isSecureTextEntry.toggle() // Toggle password visibility
        
        let eyeIcon = textField.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: eyeIcon), for: .normal)
    }
    
    
    

}

