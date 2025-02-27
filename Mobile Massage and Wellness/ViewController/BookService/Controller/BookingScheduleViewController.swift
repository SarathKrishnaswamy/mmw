//
//  BookingScheduleViewController.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 02/01/25.
//

import UIKit

class BookingScheduleViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var prefredDateTimeView: UIView!
    @IBOutlet weak var backupDateTimeView: UIView!
    @IBOutlet weak var earliestStartTimeView: UIView!
    @IBOutlet weak var latestStartTimeView: UIView!
    @IBOutlet weak var bookingFrequencyTimeView: UIView!
    
    @IBOutlet weak var frequencySubView: UIStackView!
    @IBOutlet weak var frequencyCustomView: UIStackView!
    @IBOutlet weak var frquencyEndsOnView: UIStackView!
   
    @IBOutlet weak var repeatEveryView: UIView!
    @IBOutlet weak var frequencyView: UIView!
    @IBOutlet weak var repeatView: UIView!
    @IBOutlet weak var endOnView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var occuranceView: UIView!
    
    @IBOutlet weak var preferedDateTxtField: UITextField!
    @IBOutlet weak var backDateTxtField: UITextField!
    @IBOutlet weak var earliestStartTimeTxtField: UITextField!
    @IBOutlet weak var latestStartTimeTxtField: UITextField!
    @IBOutlet weak var bookingFrequencyTxtField: UITextField!
  
    @IBOutlet weak var repeatEveryTxtField: UITextField!
    @IBOutlet weak var frequencyTxtField: UITextField!
    @IBOutlet weak var repeatTxtField: UITextField!
    @IBOutlet weak var endsOnTxtField: UITextField!
    @IBOutlet weak var dateTxtField: UITextField!
    @IBOutlet weak var occuranceTxtField: UITextField!
    
    private var timeSlots: [String] = []
    private var latestTimeSlots: [String] = []
    private var bookingFrequency = ["Select Frequency", "One Time", "Weekly", "Every 2 weeks", "Every 3 weeks", "Every 4 weeks", "Custom"]
    private var endsOn = ["Never", "On", "After"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    

    func setupUI() {
        prefredDateTimeView.layer.cornerRadius = 5
        backupDateTimeView.layer.cornerRadius = 5
        earliestStartTimeView.layer.cornerRadius = 5
        latestStartTimeView.layer.cornerRadius = 5
        bookingFrequencyTimeView.layer.cornerRadius = 5
        repeatEveryView.layer.cornerRadius = 5
        frequencyView.layer.cornerRadius = 5
        repeatView.layer.cornerRadius = 5
        endOnView.layer.cornerRadius = 5
        dateView.layer.cornerRadius = 5
        occuranceView.layer.cornerRadius = 5
        
        preferedDateTxtField.delegate = self
        backDateTxtField.delegate = self
        
        // Attach DatePickers
        preferedDateTxtField.setDatePicker(target: self, selector: #selector(doneTapped))
        backDateTxtField.setDatePicker(target: self, selector: #selector(doneTapped))
        preferedDateTxtField.disableCursor()
        backDateTxtField.disableCursor()
        earliestStartTimeTxtField.disableCursor()
        latestStartTimeTxtField.disableCursor()
        bookingFrequencyTxtField.disableCursor()
        
        setupTimeSlots()
        setupLatestTimeSlots()
        
        configureTextField(earliestStartTimeTxtField, with: timeSlots)
        configureTextField(latestStartTimeTxtField, with: latestTimeSlots)
        configureTextField(bookingFrequencyTxtField, with: bookingFrequency)
        self.frequencySubView.isHidden = true
        // Set the selection handler
        bookingFrequencyTxtField.selectionHandler = { [weak self] selectedValue in
            guard let self = self else { return }
            // Show or hide the view based on the selected value
            if selectedValue == "Select Frequency" {
                self.frequencySubView.isHidden = false
                hideCustomFrequency()
            } else if selectedValue == "One Time" {
                self.frequencySubView.isHidden = true
            } else if selectedValue == "Weekly" || selectedValue == "Every 2 weeks" || selectedValue == "Every 3 weeks" || selectedValue == "Every 4 weeks"{
                self.frequencySubView.isHidden = false
                hideCustomFrequency()
            }else{
                self.frequencySubView.isHidden = false
                showCustomFrequency()
            }
        }
        configureTextField(endsOnTxtField, with: endsOn)
        
        endsOnTxtField.selectionHandler = { [weak self] selectedValue in
            guard let self = self else { return }
            
            // Show or hide the view based on the selected value
            if selectedValue == "Never" {
                self.dateView.isHidden = true
                self.occuranceView.isHidden = true
               
            } else if selectedValue == "On" {
                self.dateView.isHidden = false
                self.occuranceView.isHidden = true
            }else{
                self.dateView.isHidden = true
                self.occuranceView.isHidden = false
            }
        }
        
       
    }
    
    func hideCustomFrequency(){
        self.frequencyCustomView.isHidden = true
    }
    
    func showCustomFrequency(){
        self.frequencyCustomView.isHidden = false
    }
    
    

    
    
    // Generate time slots from 6:00 AM to 10:00 PM
    private func setupTimeSlots() {
        let calendar = Calendar.current
        var date = calendar.date(bySettingHour: 6, minute: 0, second: 0, of: Date())!
        let endDate = calendar.date(bySettingHour: 22, minute: 0, second: 0, of: Date())!
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        while date <= endDate {
            timeSlots.append(formatter.string(from: date))
            date = calendar.date(byAdding: .hour, value: 1, to: date)!
        }
    }
    
    // Generate time slots from 8:00 AM to 7:00 AM
    private func setupLatestTimeSlots() {
        let calendar = Calendar.current
        var date = calendar.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
        // End time: 7:00 AM the next day
        let endDate = calendar.date(byAdding: .day, value: 1, to: date)!
        let finalEndDate = calendar.date(bySettingHour: 7, minute: 0, second: 0, of: endDate)!
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        while date <= finalEndDate {
            latestTimeSlots.append(formatter.string(from: date))
            date = calendar.date(byAdding: .hour, value: 1, to: date)!
        }
    }
    
    
    // Function to Configure TextFields with PickerView
    private func configureTextField(_ textField: UITextField, with data: [String]) {
        textField.delegate = self
        textField.pickerData = data // Assign picker data from extension
        
    }
    
    
    @objc func doneTapped() {
        // Identify the active text field
        if preferedDateTxtField.isFirstResponder {
            setDate(for: preferedDateTxtField)
        } else if backDateTxtField.isFirstResponder {
            setDate(for: backDateTxtField)
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
    
   

}
