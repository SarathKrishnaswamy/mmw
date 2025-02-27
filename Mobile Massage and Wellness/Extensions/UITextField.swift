//
//  TextField.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 25/12/24.
//

import Foundation
import UIKit

extension UITextField {
    func setPickerView(options: [String], target: UIViewController, doneAction: Selector?, defaultAction: Selector) {
        let picker = UIPickerView()
        picker.delegate = target as? UIPickerViewDelegate
        picker.dataSource = target as? UIPickerViewDataSource
        self.inputView = picker
        // Toolbar with Done Button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Flexible space pushes the Done button to the right
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: doneAction)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        self.inputAccessoryView = toolbar
        
        // Assign a default action for first selection
        self.addTarget(target, action: defaultAction, for: .editingDidBegin)
    }
    
    func disableCursor() {
        self.tintColor = .clear
    }
}


import UIKit

// MARK: - UITextField Extension for UIPickerView

extension UITextField {
    private struct AssociatedKeys {
        static var pickerData = "pickerData"
        static var pickerView = "pickerView"
        static var selectionHandler = "selectionHandler"
    }
    
    // Store picker data dynamically
    var pickerData: [String] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.pickerData) as? [String] ?? []
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.pickerData, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setupPicker()
        }
    }
    
    // Closure for selection callback
    var selectionHandler: ((String) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.selectionHandler) as? ((String) -> Void)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.selectionHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // UIPickerView instance
    private var pickerView: UIPickerView {
        get {
            if let picker = objc_getAssociatedObject(self, &AssociatedKeys.pickerView) as? UIPickerView {
                return picker
            } else {
                let picker = UIPickerView()
                objc_setAssociatedObject(self, &AssociatedKeys.pickerView, picker, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return picker
            }
        }
    }
    
    // Setup the picker view
    private func setupPicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
        self.inputView = pickerView
        
        // Add toolbar with Done button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTap))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        self.inputAccessoryView = toolbar
    }
    
    @objc private func doneTap() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        if pickerData.indices.contains(selectedRow) {
            let selectedValue = pickerData[selectedRow]
            self.text = selectedValue
            selectionHandler?(selectedValue) // Trigger the callback
        }
        self.resignFirstResponder() // Dismiss the picker
    }
}
// MARK: - UIPickerViewDelegate & UIPickerViewDataSource

extension UITextField: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}


extension UITextField {
    func setDatePicker(target: Any, selector: Selector, mode: UIDatePicker.Mode = .date, preferredStyle: UIDatePickerStyle = .wheels) {
        // Create DatePicker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = mode
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = preferredStyle
        }
        
        // Assign the DatePicker to inputView
        self.inputView = datePicker
        
        // Create Toolbar with Done Button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        // Assign the Toolbar to inputAccessoryView
        self.inputAccessoryView = toolbar
    }
    
}



