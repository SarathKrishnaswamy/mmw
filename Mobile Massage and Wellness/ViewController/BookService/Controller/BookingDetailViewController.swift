//
//  BookingDetailViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 02/01/25.
//

import UIKit

class BookingDetailViewController: UIViewController, UITextFieldDelegate, EditLocationDelegate {
   

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
    
    let viewModel = BookServiceViewModel()
    var bookingDetail:BookingDetail?
    
    var streetAddress:[String]?
    var treatmentType:[String]?
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
        viewModel.fetchAddresses()
        setupBindings()
        
        
        
        let sessionType = ["Single(1 therapist)"]
        configureTextField(sessionTypeTxtFld, with: sessionType)
    
    }
    
    func editLocation() {
        viewModel.fetchAddresses()
        setupBindings()
    }
    
    func deleteLocation() {
        
    }
    
    private func setupBindings() {
        viewModel.onFetchAddressesSuccess = { address in
            
            if let addressData = address.data {
                self.streetAddress = addressData.map { $0.streetAddress ?? "" } // Extracting street addresses correctly
            }
            
            if let streetAddresses = self.streetAddress {
                self.configureTextField(self.chooseServiceTxtFld, with: streetAddresses) // Passing valid array of strings
            }
            
            self.viewModel.fetchDuration()
            self.setuptratementType()
            
        }
        
        viewModel.onFetchAddressesFailure = { error in
            print("Error fetching tickets: \(error)")
        }
        
        viewModel.onFetchDurationSuccess = { duration in
            self.configureTextField(self.durationTxtFld, with: (duration.data?.duration ?? []).map { "\($0) Mins" }, isSelected: false)
            
            let treatmentAddons = ["None"]
            self.configureTextField(self.treatmentAddonsTxtFld, with: treatmentAddons, isSelected: false)
            
            let therapistGender = ["No Preference", "Female Only", "Female Preferred", "Male Only", "Male Preferred"]
            self.configureTextField(self.therapistGenderTxtFld, with: therapistGender, isSelected: false)

        }
            
            
        viewModel.onFetchADurationFailure = { error in
            print("Error fetching duration: \(error)")
        }
        
        self.chooseServiceTxtFld.selectionHandler = { [weak self] selectedValue in
            guard let self = self else { return }
                
                // Find the matching address in addressData
                if let selectedAddress = self.viewModel.addressData?.first(where: { $0.streetAddress == selectedValue }) {
                    let locationType = selectedAddress.locationType ?? "N/A"
                    let parking = selectedAddress.parking ?? "N/A"
                    let pets = selectedAddress.pets ?? "N/A"
                    
                    print("Selected Address: \(selectedValue)")
                    print("Location Type: \(locationType)")
                    print("Parking: \(parking)")
                    print("Pets: \(pets)")
                    bookingDetail?.locationType = locationType
                    bookingDetail?.parking = parking
                    bookingDetail?.pets = pets
                    
                    // You can update UI labels or other components if needed
                    
                }
        }
        
    }
    

    
    private func setuptratementType(){
        self.viewModel.fetchServicesSetting()
        viewModel.onFetchServiceSuccess = { service in
            if let serviceData = service.data?.services {
                self.treatmentType = serviceData.map { "\($0.name ?? "") - A$\($0.price ?? 0)" }

                // Extracting street addresses correctly
                self.configureTextField(self.treatmentTypeTxtFld, with: self.treatmentType ?? [String](), isSelected: false)
                self.setupAddOn()

            }
        }
        
        viewModel.onFetchServiceFailure = { error in
            print("Error fetching tickets: \(error)")
        }
        
        self.treatmentTypeTxtFld.selectionHandler = { [weak self] index in
            guard let self = self else { return }
            let parts = index.components(separatedBy: " - ")
            let result = parts.first ?? ""
            if let selectedTreatment = self.viewModel.services?.first(where: { $0.name == result }) {
                print("Price: \(selectedTreatment.price ?? 0)")
                bookingDetail?.price = String(selectedTreatment.price ?? 0)
            }
        }
    }
    
    
    private func setupAddOn(){
        self.viewModel.fetchAdon()
        viewModel.onFetchAddOnSuccess = { service in
            // Extracting street addresses correctly
            self.configureTextField(self.treatmentAddonsTxtFld, with: service.data?.treatment ?? [String]())
            self.setupTherapistGender()
        }
        
        viewModel.onFetchAddOnFailure = { error in
            print("Error fetching tickets: \(error)")
        }
    }
    
    private func setupTherapistGender(){
        self.viewModel.fetchGender()
        viewModel.onFetchGenderSuccess = { gender in
            
            // Extracting street addresses correctly
            self.configureTextField(self.therapistGenderTxtFld, with: Gender.allCasesAsStrings)
            
        }
        
        viewModel.onFetchGenderFailure = { error in
            print("Error fetching tickets: \(error)")
        }
    }
    
    
    func validateFields() -> Bool {
        guard let chooseService = chooseServiceTxtFld.text, !chooseService.isEmpty else {
            AlertUtils.showAlert(title: "", message: "Please choose Service Address", on: self)
            return false
        }
        
        guard let session = sessionTypeTxtFld.text, !session.isEmpty else {
            AlertUtils.showAlert(title: "", message: "Please Select Session Type", on: self)
            return false
        }
        
        guard let duration = durationTxtFld.text, !duration.isEmpty else {
            AlertUtils.showAlert(title: "", message: "Please Select Duration", on: self)
            return false
        }
        
        guard let treatmentType = treatmentTypeTxtFld.text, !treatmentType.isEmpty else {
            AlertUtils.showAlert(title: "", message: "Please Select Treatment Type", on: self)
            return false
        }
        
        guard let treatmentAddon = treatmentAddonsTxtFld.text, !treatmentAddon.isEmpty else {
            AlertUtils.showAlert(title: "", message: "Please Select Treatment Addon", on: self)
            return false
        }
        
        guard let gender = therapistGenderTxtFld.text, !gender.isEmpty else {
            AlertUtils.showAlert(title: "", message: "Select Gender", on: self)
            return false
        }
        
        let parts = treatmentType.components(separatedBy: " - ")
        let result = parts.first ?? ""
        bookingDetail?.address = chooseService
        bookingDetail?.sessionType = session
        bookingDetail?.duration = duration
        bookingDetail?.treatmentType = result
        bookingDetail?.addOns = treatmentAddon
        bookingDetail?.therapistGender = gender
        
        
        return true
    }
    
    
    
    
    // Function to Configure TextFields with PickerView
    private func configureTextField(_ textField: UITextField, with data: [String], isSelected: Bool? = nil) {
        textField.delegate = self
        textField.shouldPreselectFirstItem = isSelected ?? false
        textField.pickerData = data // Assign picker data from extension
        
    }
    
    
    
    @IBAction func addLocationbtnOnPressed(_ sender: Any) {
        let vc = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    
    
}
