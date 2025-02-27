//
//  BookingDetailViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 02/01/25.
//

import UIKit

class BookingDetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var chooseServiceView: UIView!
    @IBOutlet weak var sessionTypeView: UIView!
    @IBOutlet weak var durationView: UIView!
    @IBOutlet weak var treatmentTypeView: UIView!
    @IBOutlet weak var treatmentAddonsView: UIView!
    @IBOutlet weak var therapistGenderView: UIView!
    
    @IBOutlet weak var chooseServiceTxtFld: UITextField!
    @IBOutlet weak var sessionTypeTxtFld: UITextField!
    @IBOutlet weak var durationTxtFld: UITextField!
    @IBOutlet weak var treatmentTypeTxtFld: UITextField!
    @IBOutlet weak var treatmentAddonsTxtFld: UITextField!
    @IBOutlet weak var therapistGenderTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        // Set corner radius for all views
        self.chooseServiceView.layer.cornerRadius = 5
        self.sessionTypeView.layer.cornerRadius = 5
        self.durationView.layer.cornerRadius = 5
        self.treatmentTypeView.layer.cornerRadius = 5
        self.treatmentAddonsView.layer.cornerRadius = 5
        self.therapistGenderView.layer.cornerRadius = 5
        
        
        let chooseService = ["Address"]
        configureTextField(chooseServiceTxtFld, with: chooseService)
        
        let sessionType = ["Single(1 therapist)"]
        configureTextField(sessionTypeTxtFld, with: sessionType)
        
        let duration = ["60 mins"]
        configureTextField(durationTxtFld, with: duration)
        
        let treatmentType = ["Relaxtion Massage", "Deep Tissue Massage", "Remedial Massage"]
        configureTextField(treatmentTypeTxtFld, with: treatmentType)
        
        let treatmentAddons = ["None"]
        configureTextField(treatmentAddonsTxtFld, with: treatmentAddons)
        
        let therapistGender = ["No Preference", "Female Only", "Female Preferred", "Male Only", "Male Preferred"]
        configureTextField(therapistGenderTxtFld, with: therapistGender)
        
        
    }
    
    // Function to Configure TextFields with PickerView
    private func configureTextField(_ textField: UITextField, with data: [String]) {
        textField.delegate = self
        textField.pickerData = data // Assign picker data from extension
        
    }
    
    
    
    
    
    
}
