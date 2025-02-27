//
//  BookingReceiptViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 02/01/25.
//

import UIKit

class BookingReceiptViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var selectRecipientView: UIView!
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var relationshipView: UIView!
    @IBOutlet weak var selectmedicalHistoryView: UIView!
    @IBOutlet weak var provideInformationTxtView: UITextView!
    @IBOutlet weak var noteTherapistTxtView: UITextView!
    
    @IBOutlet weak var selectRecipientTxtField: UITextField!
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var mobileTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var genderTxtField: UITextField!
    @IBOutlet weak var relationshipTxtField: UITextField!
    @IBOutlet weak var selectMedicalTxtField: UITextField!
    
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var bottomView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        selectRecipientView.layer.cornerRadius = 5
        firstNameView.layer.cornerRadius = 5
        lastNameView.layer.cornerRadius = 5
        mobileView.layer.cornerRadius = 5
        emailView.layer.cornerRadius = 5
        genderView.layer.cornerRadius = 5
        relationshipView.layer.cornerRadius = 5
        selectmedicalHistoryView.layer.cornerRadius = 5
        provideInformationTxtView.layer.cornerRadius = 5
        noteTherapistTxtView.layer.cornerRadius = 5
        self.topStackView.isHidden = true
        
        let recipientData = ["Myself", "Someone else"]
        configureTextField(selectRecipientTxtField, with: recipientData)
        selectRecipientTxtField.selectionHandler = { [weak self] selectedValue in
            guard let self = self else { return }
            // Show or hide the view based on the selected value
            if selectedValue == "Myself" {
                self.topStackView.isHidden = true
            }
            else{
                self.topStackView.isHidden = false
            }
         
        }
        
        self.selectRecipientTxtField.disableCursor()
        self.selectMedicalTxtField.disableCursor()
        
        
        self.provideInformationTxtView.isHidden = true
        noteTherapistTxtView.isHidden = false
        let medicalHistoryData = ["Yes", "No"]
        configureTextField(selectMedicalTxtField, with: medicalHistoryData)
        selectMedicalTxtField.selectionHandler = { [weak self] selectedValue in
            guard let self = self else { return }
            // Show or hide the view based on the selected value
            if selectedValue == "Yes" {
                self.provideInformationTxtView.isHidden = false
            }
            else{
                self.provideInformationTxtView.isHidden = true
            }
        }
        
        
        
    }
    
    
    // Function to Configure TextFields with PickerView
    private func configureTextField(_ textField: UITextField, with data: [String]) {
        textField.delegate = self
        textField.pickerData = data // Assign picker data from extension
        
    }

}
