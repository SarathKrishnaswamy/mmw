//
//  BusinessDataViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 30/01/25.
//

import UIKit

class BusinessDataViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var organisationView: UIView!
    @IBOutlet weak var businessNumberView: UIView!
    @IBOutlet weak var businessAddressView: UIView!
    @IBOutlet weak var businessTypeView: UIView!

    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var organisationNameTxtField: UITextField!
    @IBOutlet weak var businessNumberTxtField: UITextField!
    @IBOutlet weak var businessAddressTxtField: UITextField!
    @IBOutlet weak var businessTypeTxtField: UITextField!
    
    private let viewModel = BusinessViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchBusiness()
        setupBindings()
    }
    
    func setupUI(){
        organisationView.layer.cornerRadius = 5
        businessNumberView.layer.cornerRadius = 5
        businessAddressView.layer.cornerRadius = 5
        businessTypeView.layer.cornerRadius = 5
        saveBtn.layer.cornerRadius = 5
        
    }
    
    private func setupBindings() {
        viewModel.onFetchBusinessSuccess = { profile in
            self.organisationNameTxtField.text = profile.data?.organization
            self.businessNumberTxtField.text = profile.data?.businessNumber
            self.businessAddressTxtField.text = profile.data?.businessAddress
            let business = BusinessType.getDescription(from: Int(profile.data?.businessType ?? "") ?? 0)
            self.businessTypeTxtField.text = business?.description
            self.configureTextField(self.businessTypeTxtField, with: BusinessType.allDescriptions)

            
        }

        viewModel.onFetchBusinessFailure = { error in
            print("Error fetching tickets: \(error)")
        }
        
        viewModel.onSaveBusinessSuccess = { success in
            AlertUtils.showAlert(title: "", message: success.message ?? "", on: self)
        }
        
        viewModel.onSaveBusinessFailure = { error in
            print("Error fetching tickets: \(error)")
        }
        
        
     }
    
    // Function to Configure TextFields with PickerView
    private func configureTextField(_ textField: UITextField, with data: [String]) {
        textField.delegate = self
        textField.pickerData = data // Assign picker data from extension
        
    }


   
    @IBAction func saveBtnOnPressed(_ sender: Any) {
        if self.organisationNameTxtField.text?.isEmpty ?? true {
            AlertUtils.showAlert(title: "Alert", message: "Please enter Organisation Name", on: self)
        }
        else if self.businessNumberTxtField.text?.isEmpty ?? true {
            AlertUtils.showAlert(title: "Alert", message: "Please enter Business Number", on: self)
        }
        else if self.businessTypeTxtField.text?.isEmpty ?? true {
            AlertUtils.showAlert(title: "Alert", message: "Please select Business Type", on: self)
        }
        else if self.businessAddressTxtField.text?.isEmpty ?? true {
            AlertUtils.showAlert(title: "Alert", message: "Please enter Business Address", on: self)
        }
        else{
            
            let params: [String: String] = [
                "organization": self.organisationNameTxtField.text ?? "",
                "business_number": self.businessNumberTxtField.text ?? "",
                "business_address": self.businessAddressTxtField.text ?? "",
                "business_type": String(BusinessType.getValue(from: self.businessTypeTxtField.text ?? "") ?? 0)
                
            ]
            self.viewModel.saveUser(params: params)
            print(params)
        }
    }
    
}
