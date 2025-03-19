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
    @IBOutlet weak var backupEarliestStartTimeView: UIView!
    @IBOutlet weak var backupLatestStartTimeView: UIView!
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
    @IBOutlet weak var backupEarliestStartTimeTxtField: UITextField!
    @IBOutlet weak var backupLatestStartTimeTxtField: UITextField!
    @IBOutlet weak var bookingFrequencyTxtField: UITextField!
  
    @IBOutlet weak var repeatEveryTxtField: UITextField!
    @IBOutlet weak var frequencyTxtField: UITextField!
    @IBOutlet weak var repeatTxtField: UITextField!
    @IBOutlet weak var endsOnTxtField: UITextField!
    @IBOutlet weak var dateTxtField: UITextField!
    @IBOutlet weak var occuranceTxtField: UITextField!
    
    private var timeSlots: [String] = []
    private var latestTimeSlots: [String] = []
    private var bookingFrequency = ["One Time", "Weekly", "Every 2 weeks", "Every 3 weeks", "Every 4 weeks", "Custom"]
    private var endsOn = ["Never", "On", "After"]
    private var frequency = ["Weeks","Months"]
    private var repeatTime = ["Monthly on day 10", "Monthly on the second Wednesday"]
    private let stringNumbersArray: [String] = (1...12).map { String($0) }
    var bookingDetail:BookingDetail?
    private var selectedFrequencyIndex: Int?
    private var selectedBookingMethodEndsOnIndex: Int?
    private var repeatIndex: Int?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        // UI Customization
        [prefredDateTimeView, backupDateTimeView, earliestStartTimeView, latestStartTimeView,
         bookingFrequencyTimeView, repeatEveryView, frequencyView, repeatView, endOnView,
         dateView, occuranceView].forEach { $0?.layer.cornerRadius = 5 }
        
        // Disable cursor for non-editable fields
        [preferedDateTxtField, backDateTxtField, earliestStartTimeTxtField,
         latestStartTimeTxtField, bookingFrequencyTxtField].forEach { $0?.disableCursor() }

        // Attach Date Pickers
        preferedDateTxtField.setDatePicker(target: self, selector: #selector(doneTapped))
        backDateTxtField.setDatePicker(target: self, selector: #selector(doneTapped))
        dateTxtField.setDatePicker(target: self, selector: #selector(doneTapped))
        
        
        if earliestStartTimeTxtField.text == ""{
            self.latestStartTimeView.isHidden = true
        }
        
        
        if backDateTxtField.text == ""{
            self.backupEarliestStartTimeView.isHidden = true
            self.backupLatestStartTimeView.isHidden = true
        }
        
        

        // Generate and Configure Time Slots
        setupTimeSlots()
        configureTextField(earliestStartTimeTxtField, with: timeSlots)
        configureTextField(backupEarliestStartTimeTxtField, with: timeSlots)
        configureTextField(frequencyTxtField, with: frequency)
        configureTextField(repeatTxtField, with: repeatTime)
        
        repeatTxtField.selectionHandler = { [weak self] selectedValue in
            self?.repeatIndex = (self?.repeatTime.firstIndex(of: selectedValue) ?? 0) + 1
            
        }
        
        
        
        

        // Selection Handler for Earliest Start Time
        earliestStartTimeTxtField.selectionHandler = { [weak self] selectedValue in
            guard let self = self else { return }
          
            if earliestStartTimeTxtField.text != ""{
                self.latestStartTimeView.isHidden = false
            }
            

            // Store the current latest time slot options
            let previousTimeSlots = self.latestTimeSlots

            // Generate new latest time slots based on the selected earliest time
            self.setupLatestTimeSlots(selectedTime: selectedValue)

            // Compare new slots with the previous ones
            if previousTimeSlots != self.latestTimeSlots {
                // Clear Latest Start Time TextField only if the slots have changed
                self.latestStartTimeTxtField.text = ""
            }

            // Reload Latest Start Time TextField picker with new values
            self.configureTextField(self.latestStartTimeTxtField, with: self.latestTimeSlots)
        }

        // Selection Handler for Backup Earliest Start Time
        backupEarliestStartTimeTxtField.selectionHandler = { [weak self] selectedTime in
            guard let self = self else { return }

            if backupEarliestStartTimeTxtField.text != ""{
                self.backupLatestStartTimeView.isHidden = false
            }
            
            // Store the current latest time slot options
            let previousTimeSlots = self.latestTimeSlots

            // Set the selected time in the text field
            self.backupEarliestStartTimeTxtField.text = selectedTime

            // Generate new latest time slots based on the selected backup earliest time
            self.setupLatestTimeSlots(selectedTime: selectedTime)

            // Compare new slots with the previous ones
            if previousTimeSlots != self.latestTimeSlots {
                // Clear Backup Latest Start Time TextField only if the slots have changed
                self.backupLatestStartTimeTxtField.text = ""
            }

            // Reload Backup Latest Start Time TextField picker with new values
            self.configureTextField(self.backupLatestStartTimeTxtField, with: self.latestTimeSlots)
        }
        
        
        

        // Configure Frequency and EndsOn Fields
        configureTextField(bookingFrequencyTxtField, with: bookingFrequency,isSelected: false)
        configureTextField(endsOnTxtField, with: endsOn)
        configureTextField(repeatEveryTxtField, with: stringNumbersArray)

        // Booking Frequency Selection Handler
        bookingFrequencyTxtField.selectionHandler = { [weak self] selectedValue in
            guard let self = self else { return }
            self.selectedFrequencyIndex = (self.bookingFrequency.firstIndex(of: selectedValue) ?? 0) + 1
            
            self.frequencySubView.isHidden = selectedValue == "One Time"
            if selectedValue == "Custom" {
                self.showCustomFrequency()
            } else {
                self.hideCustomFrequency()
            }
        }
        
        frequencyTxtField.selectionHandler = { [weak self] selectedValue in
            guard let self = self else { return }
            self.repeatView.isHidden = selectedValue == "Weeks"
            if selectedValue == "Months" {
                self.showRepeatView()
            } else {
                self.hideRepeatView()
            }
            
        }

        // Ends On Selection Handler
        endsOnTxtField.selectionHandler = { [weak self] selectedValue in
            guard let self = self else { return }
            self.selectedBookingMethodEndsOnIndex = (self.endsOn.firstIndex(of: selectedValue) ?? 0) + 1
            self.dateView.isHidden = selectedValue != "On"
            self.occuranceView.isHidden = selectedValue != "After"
        }

        self.frequencySubView.isHidden = true
    }

    func hideCustomFrequency() { self.frequencyCustomView.isHidden = true }
    func showCustomFrequency() { self.frequencyCustomView.isHidden = false }
    
    
    func hideRepeatView() { self.repeatView.isHidden = true }
    func showRepeatView() { self.repeatView.isHidden = false }
    
    
    func validateFields() -> Bool {
        guard let preferredDateTime = preferedDateTxtField.text, !preferredDateTime.isEmpty else {
            AlertUtils.showAlert(title: "", message: "Please Select Preferred date", on: self)
            return false
        }
        
        guard let preferredEarliestTime = earliestStartTimeTxtField.text, !preferredEarliestTime.isEmpty else {
            AlertUtils.showAlert(title: "", message: "Please Select Earliest Start Time", on: self)
            return false
        }
        
        guard let preferredLatestTime = latestStartTimeTxtField.text, !preferredLatestTime.isEmpty else {
            AlertUtils.showAlert(title: "", message: "Please Select Latest Start Time", on: self)
            return false
        }
        
        guard let backupDateTime = backDateTxtField.text, !backupDateTime.isEmpty else {
            AlertUtils.showAlert(title: "", message: "Please Select Backup Date", on: self)
            return false
        }
        
        guard let backupEarliestTime = backupEarliestStartTimeTxtField.text, !backupEarliestTime.isEmpty else {
            AlertUtils.showAlert(title: "", message: "Please Select Earliest Start Time", on: self)
            return false
        }
        
        guard let backupLatestTime = backupLatestStartTimeTxtField.text, !backupLatestTime.isEmpty else {
            AlertUtils.showAlert(title: "", message: "Please Select Latest Start Time", on: self)
            return false
        }
        
        if bookingFrequencyTxtField.text != "One Time"{
            if bookingFrequencyTxtField.text == "Weekly" || bookingFrequencyTxtField.text == "Every 2 weeks" || bookingFrequencyTxtField.text == "Every 3 weeks" || bookingFrequencyTxtField.text == "Every 4 weeks"{
                
                guard let endsOn = endsOnTxtField.text, !endsOn.isEmpty else {
                    AlertUtils.showAlert(title: "", message: "Please Select Ends on", on: self)
                    return false
                }
                
                if endsOnTxtField.text != "Never"{
                    if endsOnTxtField.text == "On"{
                        if dateTxtField.isHidden == false && dateTxtField.text == ""{
                            AlertUtils.showAlert(title: "", message: "Please Select Date", on: self)
                            return false
                        }
                    }
                    else if endsOnTxtField.text == "After"{
                         if occuranceTxtField.isHidden == false && occuranceTxtField.text == ""{
                            AlertUtils.showAlert(title: "", message: "Please Enter Occurance", on: self)
                            return false
                        }
                    }
                }
                
            }
            else if bookingFrequencyTxtField.text == "Custom"{
                guard let endsOn = endsOnTxtField.text, !endsOn.isEmpty else {
                    AlertUtils.showAlert(title: "", message: "Please Select Ends on", on: self)
                    return false
                }
                
                if endsOnTxtField.text != "Never"{
                    if endsOnTxtField.text == "On"{
                        if dateTxtField.isHidden == false && dateTxtField.text == ""{
                            AlertUtils.showAlert(title: "", message: "Please Select Date", on: self)
                            return false
                        }
                    }
                    else if endsOnTxtField.text == "After"{
                         if occuranceTxtField.isHidden == false && occuranceTxtField.text == ""{
                            AlertUtils.showAlert(title: "", message: "Please Enter Occurance", on: self)
                            return false
                        }
                    }
                }
                
                guard let repeatEvery = repeatEveryTxtField.text, !repeatEvery.isEmpty else{
                    AlertUtils.showAlert(title: "", message: "Please Select Repeat Every", on: self)
                    return false
                }
                
                guard let frequency = frequencyTxtField.text, !frequency.isEmpty else {
                    AlertUtils.showAlert(title: "", message: "Set Frequency", on: self)
                    return false
                }
                
                if frequencyTxtField.text == "Months"{
                    guard let repeatMonth = repeatTxtField.text, !repeatMonth.isEmpty else{
                        AlertUtils.showAlert(title: "", message: "Please Select Repeat", on: self)
                        return false
                    }
                }
            }
        }
        
        let date = convertDateToDateOnly(preferredDateTime)
        bookingDetail?.date = date
        bookingDetail?.earliestStartTime = preferredEarliestTime
        bookingDetail?.latestStartTime = preferredLatestTime
        bookingDetail?.bookingFrequency = String(self.selectedFrequencyIndex ?? 0)
        bookingDetail?.bookingMethodEndsOn = String(selectedBookingMethodEndsOnIndex ?? 0)
        bookingDetail?.endsOnDate = convertDateToDateOnly(dateTxtField.text ?? "")
        bookingDetail?.occurance = occuranceTxtField.text
        bookingDetail?.repeatMonth = repeatEveryTxtField.text
        bookingDetail?.repeatFrequency = frequencyTxtField.text
        bookingDetail?.monthlyRepeat = String(repeatIndex ?? 0)
        bookingDetail?.backupDate = convertToDateOnly(backupDateTime)
        bookingDetail?.backupEarlierStartTime = backupEarliestTime
        bookingDetail?.backupLatestStartTime = backupLatestTime
        
        return true
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

    // Generate time slots from 8:00 AM to 10:00 PM, starting 3 hours after selected time
    private func setupLatestTimeSlots(selectedTime: String) {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "en_US_POSIX")

        // Convert selected time string to Date object
        guard let baseDate = formatter.date(from: selectedTime) else { return }
        
        // Start time = selected time + 3 hours
        var date = calendar.date(byAdding: .hour, value: 3, to: baseDate)!

        // End time = 10:00 PM
        let finalEndDate = calendar.date(bySettingHour: 22, minute: 0, second: 0, of: Date())!

        latestTimeSlots.removeAll()
        
        while date <= finalEndDate {
            latestTimeSlots.append(formatter.string(from: date))
            date = calendar.date(byAdding: .hour, value: 1, to: date)!
        }
    }


    // Configure TextField with PickerView
    private func configureTextField(_ textField: UITextField, with data: [String], isSelected:Bool? = nil) {
        textField.delegate = self
        textField.shouldPreselectFirstItem = isSelected ?? false
        textField.pickerData = data // Assign picker data from extension
    }

    @objc func doneTapped() {
        if preferedDateTxtField.isFirstResponder {
            setDate(for: preferedDateTxtField)
        } else if backDateTxtField.isFirstResponder {
            setDate(for: backDateTxtField)
        }else if dateTxtField.isFirstResponder {
            setDate(for: dateTxtField)
        }
    }

    private func setDate(for textField: UITextField) {
        if let datePicker = textField.inputView as? UIDatePicker {
            textField.text = formatDate(datePicker.date)
            if backDateTxtField.text != ""{
                self.backupEarliestStartTimeView.isHidden = false
            }
        }
        textField.resignFirstResponder()
    }

    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}
