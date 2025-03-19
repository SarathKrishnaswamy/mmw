//
//  PreferenceDataViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 30/01/25.
//

import UIKit

class PreferenceDataViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var medicalHistoryView: UIView!
    @IBOutlet weak var provideMoreInfoView: UIView!
    @IBOutlet weak var focusAreaMassageView: UIView!
    @IBOutlet weak var towelsSheetView: UIView!
    @IBOutlet weak var pressurePreferenceView: UIView!
    @IBOutlet weak var communicationPreferenceView: UIView!
    
    
    @IBOutlet weak var medicalHistoryTextField: UITextField!
    @IBOutlet weak var provideMoreInfoTextField: UITextField!
    @IBOutlet weak var focusAreaMassageTextField: UITextField!
    @IBOutlet weak var towelsSheetTextField: UITextField!
    @IBOutlet weak var pressurePreferenceTextField: UITextField!
    @IBOutlet weak var communicationPreferenceTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var saveBtn: UIButton!
    private let viewModel = PreferenceViewModel()
    var medicalHistory = ["Yes", "No"]
    let placeholderText = "Note for your therapist" // Placeholder text
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCustomerPreferences()
        setupBindings()
    }
    
    func setupUI(){
        notesTextView.delegate = self
        notesTextView.text = placeholderText
        notesTextView.textColor = .lightGray // Placeholder text color
        self.medicalHistoryView.layer.cornerRadius = 5
        self.provideMoreInfoView.layer.cornerRadius = 5
        self.focusAreaMassageView.layer.cornerRadius = 5
        self.towelsSheetView.layer.cornerRadius = 5
        self.pressurePreferenceView.layer.cornerRadius = 5
        self.communicationPreferenceView.layer.cornerRadius = 5
        self.notesTextView.layer.cornerRadius = 5
        self.saveBtn.layer.cornerRadius = 5
        configureTextField(medicalHistoryTextField, with: medicalHistory)
        medicalHistoryTextField.selectionHandler = { [weak self] selectedValue in
            guard let self = self else { return }
            if selectedValue == "No"{
                self.provideMoreInfoView.isHidden = true
            }
            else{
                self.provideMoreInfoView.isHidden = false
            }
            
        }
        
        
    }
    
    private func setupBindings() {
        viewModel.onFetchSuccess = { preference in
            DispatchQueue.main.async {
                self.medicalHistoryTextField.text = preference.data?.awareOption
                if preference.data?.awareOption == "No"{
                    self.provideMoreInfoView.isHidden = true
                }
                else{
                    self.provideMoreInfoView.isHidden = false
                    self.provideMoreInfoTextField.text = preference.data?.moreInfo
                }
                
                if let preferences = self.viewModel.preferencesData {
                    let selectedArea = self.viewModel.getPickerValue(from: preference.data?.areas ?? "", for: preferences.areasDict)
                    let towelSheet = self.viewModel.getPickerValue(from: preference.data?.towelsSheet ?? "", for: preferences.towelsSheetDict)
                    let pressurePreference = self.viewModel.getPickerValue(from: preference.data?.pressurePreference ?? "", for: preferences.pressurePreferenceDict)
                    let communicationPreference = self.viewModel.getPickerValue(from: preference.data?.communicationPreference ?? "", for: preferences.communicationPreferenceDict)
                    self.focusAreaMassageTextField.text = selectedArea
                    self.towelsSheetTextField.text = towelSheet
                    self.pressurePreferenceTextField.text = pressurePreference
                    self.communicationPreferenceTextField.text = communicationPreference
                    if preference.data?.note == "" {
                        self.notesTextView.text = self.placeholderText
                    }
                    else{
                        self.notesTextView.textColor = .black
                        self.notesTextView.text = preference.data?.note ?? ""
                    }
                    
                }
            }
            
        }

        viewModel.onFetchFailure = { error in
            print("Error fetching tickets: \(error)")
        }
        
        viewModel.onSaveSuccess = { success in
            AlertUtils.showAlert(title: "", message: success.message ?? "", on: self)
        }
        
        viewModel.onSaveFailure = { error in
            print("Error fetching tickets: \(error)")
        }
        
        viewModel.onFetchCustomerSuccess = { customer in
            self.configureTextField(self.focusAreaMassageTextField, with: customer.data?.areas ?? [String]())
            self.configureTextField(self.towelsSheetTextField, with: customer.data?.towelsSheet ?? [String]())
            self.configureTextField(self.pressurePreferenceTextField, with: customer.data?.pressurePreference ?? [String]())
            self.configureTextField(self.communicationPreferenceTextField, with: customer.data?.communicationPreference ?? [String]())
            self.viewModel.fetchPreferences()
            
        }
        viewModel.onFetchCustomerFailure = { error in
            print("Error fetching tickets: \(error)")
        }
        
        
     }
    
    
    // Function to Configure TextFields with PickerView
    private func configureTextField(_ textField: UITextField, with data: [String]) {
        textField.delegate = self
        textField.pickerData = data // Assign picker data from extension
        
    }


    @IBAction func saveBtnOnPressed(_ sender: Any) {
        if focusAreaMassageTextField.text == "" {
            AlertUtils.showAlert(title: "Error", message: "Please select focus area for massage", on: self)
        }
        else if towelsSheetTextField.text == "" {
            AlertUtils.showAlert(title: "Error", message: "Please select Towels / Sheet Preference", on: self)
        }
        else if pressurePreferenceTextField.text == "" {
            AlertUtils.showAlert(title: "Error", message: "Please select Pressure Preference", on: self)
        }
        else if communicationPreferenceTextField.text == "" {
            AlertUtils.showAlert(title: "Error", message: "Please select Communication Preference", on: self)
        }
        else{
            let areaValue = self.viewModel.getPickerKey(for: self.focusAreaMassageTextField.text ?? "", in: self.viewModel.preferencesData?.areasDict)
            let towelSheetValue = self.viewModel.getPickerKey(for: self.towelsSheetTextField.text ?? "", in: self.viewModel.preferencesData?.towelsSheetDict)
            let pressurePreferenceValue = self.viewModel.getPickerKey(for: self.pressurePreferenceTextField.text ?? "", in: self.viewModel.preferencesData?.pressurePreferenceDict)
            let communicationPreferenceValue = self.viewModel.getPickerKey(for: self.communicationPreferenceTextField.text ?? "", in: self.viewModel.preferencesData?.communicationPreferenceDict)
            
            if self.notesTextView.text == placeholderText {
                self.notesTextView.text = ""
            }
            
            let params = [
                "awareOption":self.medicalHistoryTextField.text ?? "",
                "more_info":self.provideMoreInfoTextField.text ?? "",
                "areas":areaValue ?? "",
                "allergies":"2",
                "towels_sheet":towelSheetValue ?? "",
                "presure_preference":pressurePreferenceValue ?? "",
                "communication_preference":communicationPreferenceValue ?? "",
                "note":self.notesTextView.text ?? ""
            ]
            self.viewModel.savePreferences(params: params)
        }
        
    }
    
}

// MARK: - UITextViewDelegate
extension PreferenceDataViewController: UITextViewDelegate {
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
    
}
