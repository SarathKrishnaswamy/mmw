//
//  FilterBookinHistoryViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 23/01/25.
//

import UIKit

class FilterBookinHistoryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var providerView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var serviceView: UIView!
    @IBOutlet weak var paymentDateFromView: UIView!
    @IBOutlet weak var paymentDateToView: UIView!
    @IBOutlet weak var scheduleDateFromView: UIView!
    @IBOutlet weak var scheduleDateToView: UIView!
    @IBOutlet weak var bookingStatusView: UIView!
    
    @IBOutlet weak var providerTxtField: UITextField!
    @IBOutlet weak var locationTxtField: UITextField!
    @IBOutlet weak var servicesTxtField: UITextField!
    @IBOutlet weak var paymentDateFromTxtField: UITextField!
    @IBOutlet weak var paymentDateToTxtField: UITextField!
    @IBOutlet weak var scheduleDateFromTxtField: UITextField!
    @IBOutlet weak var scheduleDateToTxtField: UITextField!
    @IBOutlet weak var bookingStatusTxtField: UITextField!
    
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    
    var model : BookingHistoryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        let providerNames = model?.data?.metadata?.providers?.compactMap { $0.name } ?? []
        let locations = model?.data?.metadata?.locations?.compactMap { $0.street_address } ?? []
        let services = model?.data?.metadata?.services?.compactMap { $0.name } ?? []
        if let statuses = model?.data?.metadata?.statuses {
            let statusValues = [
                statuses.status0,
                statuses.status1,
                statuses.status2,
                statuses.status3,
                statuses.status4,
                statuses.status5,
                statuses.status6,
                statuses.status7
            ].compactMap { $0 } // Removes nil values

            configureTextField(bookingStatusTxtField, with: statusValues)
        }
        configureTextField(providerTxtField, with:providerNames)
        configureTextField(locationTxtField, with:locations)
        configureTextField(servicesTxtField, with:services)
        //configureTextField(bookingStatusTxtField, with: statuses)
    }
    
    func setupUI(){
        providerView.layer.cornerRadius = 5
        locationView.layer.cornerRadius = 5
        serviceView.layer.cornerRadius = 5
        paymentDateFromView.layer.cornerRadius = 5
        paymentDateToView.layer.cornerRadius = 5
        scheduleDateFromView.layer.cornerRadius = 5
        scheduleDateToView.layer.cornerRadius = 5
        bookingStatusView.layer.cornerRadius = 5
        applyBtn.layer.cornerRadius = 5
        clearBtn.layer.cornerRadius = 5
        paymentDateFromTxtField.delegate = self
        paymentDateToTxtField.delegate = self
        scheduleDateFromTxtField.delegate = self
        scheduleDateToTxtField.delegate = self
        scheduleDateFromTxtField.disableCursor()
        scheduleDateToTxtField.disableCursor()
        paymentDateFromTxtField.disableCursor()
        paymentDateToTxtField.disableCursor()
        
        paymentDateFromTxtField.setDatePicker(target: self, selector: #selector(doneTapped))
        paymentDateToTxtField.setDatePicker(target: self, selector: #selector(doneTapped))
        scheduleDateFromTxtField.setDatePicker(target: self, selector: #selector(doneTapped))
        scheduleDateToTxtField.setDatePicker(target: self, selector: #selector(doneTapped))
    }
    
    // Function to Configure TextFields with PickerView
    private func configureTextField(_ textField: UITextField, with data: [String]) {
        textField.delegate = self
        textField.pickerData = data // Assign picker data from extension
        
    }
    
    @objc func doneTapped() {
        // Identify the active text field
        if paymentDateFromTxtField.isFirstResponder {
            setDate(for: paymentDateFromTxtField)
        } else if paymentDateToTxtField.isFirstResponder {
            setDate(for: paymentDateToTxtField)
        }
        else if scheduleDateFromTxtField.isFirstResponder {
            setDate(for: scheduleDateFromTxtField)
        }
        else if scheduleDateToTxtField.isFirstResponder {
            setDate(for: scheduleDateToTxtField)
        }
    }
    
    private func setDate(for textField: UITextField) {
        if let datePicker = textField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            textField.text = dateFormatter.string(from: datePicker.date)
        }
        textField.resignFirstResponder()
    }

    @IBAction func closebtnOnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func clearBtnOnPressed(_ sender: Any) {
        self.providerTxtField.text = ""
        self.locationTxtField.text = ""
        self.servicesTxtField.text = ""
        self.paymentDateFromTxtField.text = ""
        self.paymentDateToTxtField.text = ""
        self.scheduleDateFromTxtField.text = ""
        self.scheduleDateToTxtField.text = ""
        self.bookingStatusTxtField.text = ""
    }
    
}
