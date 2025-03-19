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
    
    let placeholderText = "Note for Therapist"
    let medicalHistoryPlaceholderText = "Please provide more information"
    let gender = ["Male", "Female", "Other"]
    let relationship = ["Spouse", "Parent", "Friend", "Boss/Colleague", "Client"]
    let viewModel = BookServiceViewModel()
    var bookingDetail:BookingDetail?
    var selectedRecipeient:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.viewModel.fetchUser()
        setupBindings()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        provideInformationTxtView.delegate = self
        provideInformationTxtView.text = medicalHistoryPlaceholderText
        provideInformationTxtView.textColor = .lightGray 
        
        noteTherapistTxtView.delegate = self
        noteTherapistTxtView.text = placeholderText
        noteTherapistTxtView.textColor = .lightGray // Placeholder text color
        
        let recipientData = ["Myself", "Someone else"]
        configureTextField(selectRecipientTxtField, with: recipientData, selectedValue: true)
        selectRecipientTxtField.selectionHandler = { [weak self] selectedValue in
            guard let self = self else { return }
            self.selectedRecipeient = (recipientData.firstIndex(of: selectedValue) ?? 0) + 1
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
        self.selectMedicalTxtField.text = "No"
        configureTextField(selectMedicalTxtField, with: medicalHistoryData)
        selectMedicalTxtField.selectionHandler = { [weak self] selectedValue in
            guard let self = self else { return }
            // Show or hide the view based on the selected value
            if selectedValue == "Yes" {
                self.provideInformationTxtView.isHidden = false
                self.bookingDetail?.medicalHistory = "1"
            }
            else{
                self.provideInformationTxtView.isHidden = true
                self.bookingDetail?.medicalHistory = "0"
            }
        }
        
        configureTextField(genderTxtField, with: gender)
        configureTextField(relationshipTxtField, with: relationship)
        self.relationshipTxtField.selectionHandler = { [weak self] selectedValue in
            if let index = self?.relationship.firstIndex(of: selectedValue) {
                print("Index: \(index+1)")
                self?.bookingDetail?.relationship = String(index + 1)
            }
        }
    }
    
    private func setupBindings() {
        viewModel.onFetchUserSuccess = { profile in
//            self.firstNameTxtField.text = profile.data?.firstname
//            self.lastNameTxtField.text = profile.data?.lastname
//            self.mobileTxtField.text = profile.data?.mobileNo
//            self.emailTxtField.text = profile.data?.email
//            self.genderTxtField.text = profile.data?.gender
        }
        
        viewModel.onFetchUserFailure = { error in
            print("Error fetching tickets: \(error)")
        }
    }
    
    func validateFields() -> Bool {
        if selectRecipientTxtField.text == "Myself"{
            if noteTherapistTxtView.text == placeholderText{
                AlertUtils.showAlert(title: "", message: "Please Enter Notes for Therapist", on: self)
                return false
            }
        }
        else{
            guard let fname = firstNameTxtField.text, !fname.isEmpty else {
                AlertUtils.showAlert(title: "", message: "Please Enter First Name", on: self)
                return false
            }
            
            guard let lname = lastNameTxtField.text, !lname.isEmpty else {
                AlertUtils.showAlert(title: "", message: "Please Enter Last Name", on: self)
                return false
            }
            
            guard let mobile = mobileTxtField.text, !mobile.isEmpty else {
                AlertUtils.showAlert(title: "", message: "Please Enter Mobile Number", on: self)
                return false
            }
            
            if !isValidPhoneNumber(mobileTxtField.text ?? ""){
                AlertUtils.showAlert(title: "", message: "Please Enter Valid Mobile Number", on: self)
                return false
            }
            
            guard let email = emailTxtField.text, !email.isEmpty else {
                AlertUtils.showAlert(title: "", message: "Please Enter Email", on: self)
                return false
            }
            
            if !isValidEmail(emailTxtField.text ?? ""){
                AlertUtils.showAlert(title: "", message: "Please Enter Valid Email", on: self)
                return false
            }
            
            guard let gender = genderTxtField.text, !gender.isEmpty else {
                AlertUtils.showAlert(title: "", message: "Select Gender", on: self)
                return false
            }
            
            guard let relationship = relationshipTxtField.text, !relationship.isEmpty else {
                AlertUtils.showAlert(title: "", message: "Please Select Relationship", on: self)
                return false
            }
            
            if noteTherapistTxtView.text == placeholderText{
                AlertUtils.showAlert(title: "", message: "Please Enter Notes for Therapist", on: self)
                return false
            }
        }
        if selectRecipientTxtField.text == "Myself"{
            bookingDetail?.recipient = String(1)
            bookingDetail?.firstName = self.viewModel.userData?.firstname
            bookingDetail?.lastName = self.viewModel.userData?.lastname
            bookingDetail?.mobileNumber = self.viewModel.userData?.mobileNo
            bookingDetail?.email = self.viewModel.userData?.email
            bookingDetail?.gender = self.viewModel.userData?.gender
            bookingDetail?.therapistNote = noteTherapistTxtView.text
            bookingDetail?.additionalNote = provideInformationTxtView.text
            
        }
        else{
            bookingDetail?.recipient = String(2)
            bookingDetail?.firstName = firstNameTxtField.text ?? ""
            bookingDetail?.lastName = lastNameTxtField.text ?? ""
            bookingDetail?.mobileNumber = mobileTxtField.text ?? ""
            bookingDetail?.email = emailTxtField.text ?? ""
            bookingDetail?.gender = "2"
            bookingDetail?.therapistNote = noteTherapistTxtView.text
            bookingDetail?.additionalNote = provideInformationTxtView.text
        }
        
        return true
    }
    
    
    // Function to Configure TextFields with PickerView
    private func configureTextField(_ textField: UITextField, with data: [String], selectedValue:Bool? = nil) {
        textField.delegate = self
        textField.shouldPreselectFirstItem = selectedValue ?? false
        textField.pickerData = data // Assign picker data from extension
        
    }

}


extension BookingReceiptViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = ""
            textView.textColor = .black // Change text color when user starts typing
        }
        
        if textView == provideInformationTxtView {
            if textView.text == medicalHistoryPlaceholderText {
                textView.text = ""
                textView.textColor = .black // Change text color when user starts typing
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray // Restore placeholder color
        }
    }
}
