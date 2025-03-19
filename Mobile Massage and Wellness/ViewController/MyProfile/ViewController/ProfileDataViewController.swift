//
//  ProfileDataViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 30/01/25.
//

import UIKit

class ProfileDataViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var genderView: UIView!
    
    
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var mobileTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var dobTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var genderTxtField: UITextField!
    
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    private let viewModel = ProfileViewModel()
    var vaccinate:Int? = 0
    var isVaccinated:Bool? = false
    var gender = ["Male","Female","Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUser()
        setupBindings()
    }
    
    

    func setupUI(){
        firstNameView.layer.cornerRadius = 5
        lastNameView.layer.cornerRadius = 5
        mobileView.layer.cornerRadius = 5
        emailView.layer.cornerRadius = 5
        dobView.layer.cornerRadius = 5
        addressView.layer.cornerRadius = 5
        genderView.layer.cornerRadius = 5
        checkBoxBtn.layer.cornerRadius = 5
        saveBtn.layer.cornerRadius = 5
        configureTextField(genderTxtField, with: gender)
        dobTxtField.setDatePicker(target: self, selector: #selector(doneTapped))
    }
    
    
    private func setupBindings() {
        viewModel.onFetchUserSuccess = { profile in
            self.firstNameTxtField.text = profile.data?.firstname
            self.lastNameTxtField.text = profile.data?.lastname
            self.mobileTxtField.text = profile.data?.mobileNo
            self.emailTxtField.text = profile.data?.email
            self.dobTxtField.text = profile.data?.dob
            self.addressTxtField.text = profile.data?.address
            self.genderTxtField.text = profile.data?.gender
            if profile.data?.vaccinate == "1" {
                self.checkBoxBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
                self.isVaccinated = true
                self.vaccinate = 1
            }
            else if profile.data?.vaccinate == "0"{
                self.checkBoxBtn.setImage(UIImage(systemName: ""), for: .normal)
                self.isVaccinated = false
                self.vaccinate = 0
            }
        }

        viewModel.onFetchUserFailure = { error in
            print("Error fetching tickets: \(error)")
        }
        
        viewModel.onSaveUserSuccess = { success in
            AlertUtils.showAlert(title: "", message: success.message ?? "", on: self)
        }
        
        viewModel.onSaveUserFailure = { error in
            print("Error fetching tickets: \(error)")
        }
        
        
     }
    
    @objc func doneTapped() {
        // Identify the active text field
        if dobTxtField.isFirstResponder {
            setDate(for: dobTxtField)
        }
    }
    
    
    private func setDate(for textField: UITextField) {
        if let datePicker = textField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            textField.text = dateFormatter.string(from: datePicker.date)
        }
        textField.resignFirstResponder()
    }
    
    
    // Function to Configure TextFields with PickerView
    private func configureTextField(_ textField: UITextField, with data: [String]) {
        textField.delegate = self
        textField.pickerData = data // Assign picker data from extension
        
    }

    
    @IBAction func saveBtnOnPressed(_ sender: Any) {
        if self.firstNameTxtField.text?.isEmpty ?? true {
            AlertUtils.showAlert(title: "Error", message: "Please enter first name", on: self)
        }
        else if lastNameTxtField.text?.isEmpty ?? true {
            AlertUtils.showAlert(title: "Error", message: "Please enter last name", on: self)
        }
        else if mobileTxtField.text?.isEmpty ?? true {
            AlertUtils.showAlert(title: "Error", message: "Please enter mobile number", on: self)
        }
        else if emailTxtField.text?.isEmpty ?? true {
            AlertUtils.showAlert(title: "Error", message: "Please enter email", on: self)
        }
        else if addressTxtField.text?.isEmpty ?? true {
            AlertUtils.showAlert(title: "Error", message: "Please enter address", on: self)
        }
        else{
            let params: [String: String] = [
                "firstname": firstNameTxtField.text ?? "",
                "lastname": lastNameTxtField.text ?? "",
                "address": addressTxtField.text ?? "",
                "email": emailTxtField.text ?? "",
                "mobile_no": mobileTxtField.text ?? "",
                "gender":genderTxtField.text ?? "",
                "dob":dobTxtField.text ?? "",
                "vaccinate": "\(vaccinate ?? 0)"
            ]
            viewModel.saveUser(params: params)
        }
    }
    
    
    @IBAction func vaccinateBtnOnPressed(_ sender: Any) {
        if isVaccinated == false {
            self.checkBoxBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
            self.isVaccinated = true
            self.vaccinate = 1
        }
        else{
            self.checkBoxBtn.setImage(UIImage(systemName: ""), for: .normal)
            self.isVaccinated = false
            self.vaccinate = 0
        }
    }
    
   

}
