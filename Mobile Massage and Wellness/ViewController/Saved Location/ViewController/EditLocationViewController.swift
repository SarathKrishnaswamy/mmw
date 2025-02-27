//
//  EditLocationViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 20/01/25.
//

import UIKit

protocol EditLocationDelegate: AnyObject {
    func editLocation()
    func deleteLocation()
}

class EditLocationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var enterAddressView: UIView!
    @IBOutlet weak var locationTypeView: UIView!
    @IBOutlet weak var parkingView: UIView!
    @IBOutlet weak var stairsLocationView: UIView!
    @IBOutlet weak var petsLocationView: UIView!
    @IBOutlet weak var locationNotes: UIView!
    
    @IBOutlet weak var enterAddressTxtField: UITextField!
    @IBOutlet weak var locationTypeTxtField: UITextField!
    @IBOutlet weak var parkingTxtField: UITextField!
    @IBOutlet weak var stairsTxtField: UITextField!
    @IBOutlet weak var petsTxtField: UITextField!
    @IBOutlet weak var locationNotesTxtField: UITextField!
    
    @IBOutlet weak var addLocationBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    private let viewModel = LocationViewModel()
    var delegate: EditLocationDelegate?
    
    var id:Int?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchLocations()
        viewModel.fetchAddressesView(id: "\(id ?? 0)")
        setupBindings()
    }
    
    
    
    private func setupBindings() {
        viewModel.onFetchLocationsSuccess = { locations in
            self.configureTextField(self.locationTypeTxtField, with: self.viewModel.locationData?.locationType ?? [String]())
            self.configureTextField(self.parkingTxtField, with: self.viewModel.locationData?.parking ?? [String]())
            self.configureTextField(self.stairsTxtField, with: self.viewModel.locationData?.haveStairs ?? [String]())
            self.configureTextField(self.petsTxtField, with: self.viewModel.locationData?.havePets ?? [String]())
        }
        
        viewModel.onFetchLocationsFailure = { error in
            print("Error fetching locations: \(error)")
            
        }
        
        viewModel.onFetchAddressesViewSuccess = { addresses in
            self.enterAddressTxtField.text = addresses.addresses?.first?.streetAddress ?? ""
            self.locationTypeTxtField.text = addresses.addresses?.first?.locationType ?? ""
            self.parkingTxtField.text = addresses.addresses?.first?.parking ?? ""
            self.stairsTxtField.text = addresses.addresses?.first?.access ?? ""
            self.petsTxtField.text = addresses.addresses?.first?.pets ?? ""
            self.locationNotesTxtField.text = addresses.addresses?.first?.notes ?? ""
        }
        
        viewModel.onFetchAddressesViewFailure = { error in
            print("Error fetching locations: \(error)")
        }
        
        
        viewModel.onFetchAddressesUpdateSuccess = { success in
            
            AlertUtils.showAlert(title: "Success", message: success.message ?? "", on: self) {
                self.dismiss(animated: true) {
                    self.delegate?.editLocation()
                }
            }
            
        }
        
        viewModel.onFetchAddressesUpdateFailure = { error in
            print("Error fetching locations: \(error)")
        }
        
        viewModel.onDeleteAddressSuccess = { success in
            AlertUtils.showAlert(title: "Success", message: success.message ?? "", on: self) {
                self.dismiss(animated: true) {
                    self.delegate?.editLocation()
                }
            }
        }
        
        viewModel.onDeleteAddressFailure = { error in
            print("Error fetching locations: \(error)")
        }
        
        
    }
    

    func setupUI(){
        enterAddressView.layer.cornerRadius = 5
        locationTypeView.layer.cornerRadius = 5
        parkingView.layer.cornerRadius = 5
        stairsLocationView.layer.cornerRadius = 5
        petsLocationView.layer.cornerRadius = 5
        locationNotes.layer.cornerRadius = 5
        addLocationBtn.layer.cornerRadius = 5
        deleteBtn.layer.cornerRadius = 5
 
    }
    
    // Function to Configure TextFields with PickerView
    private func configureTextField(_ textField: UITextField, with data: [String]) {
        textField.delegate = self
        textField.pickerData = data // Assign picker data from extension
        
    }
    
    
    @IBAction func closebtnOnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deleteBtnOnPressed(_ sender: Any) {
        AlertUtils.showAlertTwoButtons(title: "", message: "Are you sure you want to delete this saved location?", on: self, primaryActionTitle: "Yes",secondaryActionTitle: "No",primaryActionHandler: {
            print("User tapped Yes")
            self.viewModel.deleteAddressView(id: "\(self.id ?? 0)")
            // Perform action for Yes
        },secondaryActionHandler: {
            print("User tapped No")
            // Perform action for No
        })
    }
    
    
    @IBAction func updateLocationOnPressed(_ sender: Any) {
        if self.enterAddressTxtField.text?.isEmpty == true{
            AlertUtils.showAlert(title: "", message: "Enter your Address", on: self)
        }
        else if self.locationTypeTxtField.text?.isEmpty == true{
            AlertUtils.showAlert(title: "", message: "Enter your Location Type", on: self)
        }
        else if self.parkingTxtField.text?.isEmpty == true{
            AlertUtils.showAlert(title: "", message: "Enter your Parking", on: self)
        }
        else if self.stairsTxtField.text?.isEmpty == true{
            AlertUtils.showAlert(title: "", message: "Enter your Stairs", on: self)
        }
        else if self.petsTxtField.text?.isEmpty == true{
            AlertUtils.showAlert(title: "", message: "Enter your Pets", on: self)
        }
        else{
            let parameters: [String: Any] = [
                "address": self.enterAddressTxtField.text ?? "",
                "location_type": self.locationTypeTxtField.text ?? "",
                "parking": self.parkingTxtField.text ?? "",
                "have_stairs": self.stairsTxtField.text ?? "",
                "have_pets": self.petsTxtField.text ?? "",
                "notes":self.locationNotesTxtField.text ?? ""
            ]
            self.viewModel.updateAddressView(id: "\(self.id ?? 0)", parameters: parameters)
        }
    }
}
