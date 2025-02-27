//
//  SignUpViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 25/12/24.
//

import UIKit
import CountryPickerView

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cnfPasswordTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var checkBoxView: UIView!
    @IBOutlet weak var checkmarkBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var mobileVerifyOtpBtn: UIButton!
    @IBOutlet weak var emailVerifyOtpBtn: UIButton!
    
    weak var cpvTextField: CountryPickerView!
    let cpvInternal = CountryPickerView()
    var isMobileVerified: Bool = false
    var isEmailVerified: Bool = false
    var acceptTerms: Bool = false
    var countryCode:String = ""
    private let viewModel = SignupViewModel()
    
    private let genderOptions = ["Male", "Female", "Other"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    //SetupUI
    func setupUI() {
        // Create the country picker and center it inside the container
        let cp = CountryPickerView(frame: CGRect(x: 15, y: 0, width: 10, height: 30)) // Adjust width to fit
        print(cp.selectedCountry)
        self.countryCode = cp.selectedCountry.phoneCode
        //containerView.addSubview(cp)

        // Assign left view to the text field
        mobileTextField.leftView = cp
        mobileTextField.leftViewMode = .always
        mobileTextField.placeholder = "Mobile" // Ensure placeholder is visible
        mobileTextField.keyboardType = .phonePad
        mobileTextField.borderStyle = .roundedRect // Optional: Ensure UI looks good

        // Set padding so the text doesn't overlap with the left view
        mobileTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0) // Add left padding

        cp.delegate = self
       // cp.showPhoneCodeInView = true // Show country code (e.g., +91)

        // Apply styling to buttons and checkboxes
        checkBoxView.layer.cornerRadius = 5
        signinBtn.layer.cornerRadius = 5
        signupBtn.layer.cornerRadius = 5

        // Set up picker view for gender selection
        genderTextField.setPickerView(
            options: genderOptions,
            target: self,
            doneAction: #selector(doneButtonTapped),
            defaultAction: #selector(selectFirstOption)
        )
        
        genderTextField.disableCursor()
        genderTextField.delegate = self

        // Add eye icon for password fields
        addEyeIconToTextField(passwordTextField)
        addEyeIconToTextField(cnfPasswordTextField)
        setupBindings()
    }
    
    
    private func setupBindings() {
        viewModel.onSignupSuccess = { response in
            print(response)
            self.navigationController?.popViewController(animated: true)
                 
         }
        viewModel.onSignupFailure = { error in
             print("Login Failed: \(error)")
         }
     }


    
    
    // MARK: - Done Button Action
    @objc func doneButtonTapped() {
        // Dismiss the picker view
        genderTextField.resignFirstResponder()
    }
    
    
    // MARK: - UITextField Action
    @objc func selectFirstOption() {
        // Set the default picker value to the first option
        if let picker = genderTextField.inputView as? UIPickerView {
            picker.selectRow(0, inComponent: 0, animated: true)
            genderTextField.text = genderOptions[0]
        }
    }
    
    @IBAction func signupBtnOnPressed(_ sender: Any) {
        if firstNameTextField.text == ""{
            AlertUtils.showAlert(title: "Alert", message: "Please enter your first name", on: self)
        }
        else if lastNameTextField.text == ""{
            AlertUtils.showAlert(title: "Alert", message: "Please enter your last name", on: self)
        }
        else if genderTextField.text == ""{
            AlertUtils.showAlert(title: "Alert", message: "Select Gender", on: self)
        }
        else if mobileTextField.text == ""{
            AlertUtils.showAlert(title: "Alert", message: "Please enter your mobile number", on: self)
        }
        else if !isValidPhoneNumber(mobileTextField.text ?? ""){
            AlertUtils.showAlert(title: "Alert", message: "Please enter valid mobile number", on: self)
        }
        else if isMobileVerified == false{
            AlertUtils.showAlert(title: "Alert", message: "Phone Not Verified. Please verify your mobile number", on: self)
        }
        else if emailTextField.text == ""{
            AlertUtils.showAlert(title: "Alert", message: "Please enter your email address", on: self)
        }
        else if !isValidEmail(emailTextField.text ?? ""){
            AlertUtils.showAlert(title: "Alert", message: "Please enter valid email address", on: self)
        }
        else if isEmailVerified == false{
            AlertUtils.showAlert(title: "Alert", message: "Email Not Verified. Please verify your email address", on: self)
        }
        else if passwordTextField.text == ""{
            AlertUtils.showAlert(title: "Alert", message: "Please Enter password", on: self)
        }
        else if cnfPasswordTextField.text == ""{
            AlertUtils.showAlert(title: "Alert", message: "Please Enter Repeat password", on: self)
        }
        else if passwordTextField.text != cnfPasswordTextField.text{
            AlertUtils.showAlert(title: "Alert", message: "Password Mismatching", on: self)
        }
        else if addressTextField.text == ""{
            AlertUtils.showAlert(title: "Alert", message: "Enter your address", on: self)
        }
        else if acceptTerms == false{
            AlertUtils.showAlert(title: "Alert", message: "Please accept the terms and conditions and privacy policy", on: self)
        }
        else{
            viewModel.signup(firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", gender: genderTextField.text ?? "", mobile: mobileTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "", address: addressTextField.text ?? "", toc: acceptTerms)
        }
    }
    
    @IBAction func signinBtnOnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func verifyPhoneOTPOnPressed(_ sender: Any) {
        if mobileTextField.text?.isEmpty ?? false{
            AlertUtils.showAlert(title: "Alert", message: "Please enter your mobile number", on: self)
        }else{
            if isValidPhoneNumber(mobileTextField.text ?? ""){
                let vc = storyboard?.instantiateViewController(withIdentifier: "VerifyOTPViewController") as! VerifyOTPViewController
                vc.modalPresentationStyle = .overCurrentContext
                vc.delegate = self
                vc.isMobileVerified = true
                vc.mobile = mobileTextField.text ?? ""
                vc.countryCode = countryCode
                self.present(vc, animated: true)
            }
            else{
                AlertUtils.showAlert(title: "Alert", message: "Please enter your valid mobile number", on: self)
            }
            
        }
    }
    
    @IBAction func verifyEmailOTPOnPressed(_ sender: Any) {
        if emailTextField.text?.isEmpty ?? false{
            AlertUtils.showAlert(title: "Alert", message: "Please enter your email address", on: self)
        }else{
            if isValidEmail(emailTextField.text ?? ""){
                let vc = storyboard?.instantiateViewController(withIdentifier: "VerifyOTPViewController") as! VerifyOTPViewController
                vc.modalPresentationStyle = .overCurrentContext
                vc.delegate = self
                vc.isEmailVerified = true
                vc.email = emailTextField.text ?? ""
                self.present(vc, animated: true)
            }
            else{
                AlertUtils.showAlert(title: "Alert", message: "Please enter your valid email address", on: self)
            }
        }
        
    }
    
    
    @IBAction func checkMarkBtnOnPressed(_ sender: Any) {
        if acceptTerms == false{
            acceptTerms = true
            checkmarkBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }
        else{
            acceptTerms = false
            checkmarkBtn.setImage(UIImage(systemName: ""), for: .normal)
        }
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


extension SignUpViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderOptions.count
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Update the text field with the selected value
        genderTextField.text = genderOptions[row]
    }
}


extension SignUpViewController: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        // Only countryPickerInternal has it's delegate set
        let title = "Selected Country"
        let message = "Name: \(country.name) \nCode: \(country.code) \nPhone: \(country.phoneCode)"
        print(message)
        //showAlert(title: title, message: message)
        countryCode = country.phoneCode
    }
}


extension SignUpViewController:VerifyOTPDelegate{
    func didMobileVerifyOTP(isMobileVerified: Bool) {
        self.mobileVerifyOtpBtn.setTitle(isMobileVerified ? "Verified" : "Verify OTP", for: .normal)
        if isMobileVerified{
            self.isMobileVerified = true
            self.mobileVerifyOtpBtn.isEnabled = false
        }else{
            self.isMobileVerified = false
            self.mobileVerifyOtpBtn.isEnabled = true
        }
    }
    
    func didEmailVerifyOTP(isEmailVerified: Bool) {
        self.emailVerifyOtpBtn.setTitle(isEmailVerified ? "Verified" : "Verify OTP", for: .normal)
        if isEmailVerified{
            self.isEmailVerified = true
            self.emailVerifyOtpBtn.isEnabled = false
        }
        else{
            self.isEmailVerified = false
            self.emailVerifyOtpBtn.isEnabled = true
        }
    }
}
