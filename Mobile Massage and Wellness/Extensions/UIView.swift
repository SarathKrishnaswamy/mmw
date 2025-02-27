//
//  UIView.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 06/01/25.
//

import UIKit

extension UIView {
    /// Adds a tap gesture recognizer to the view and links it to a UITextField
    /// - Parameters:
    ///   - textField: The UITextField to be triggered when the view is tapped
    ///   - target: The UIViewController instance handling the action
    func addTapGesture(for textField: UITextField, target: UIViewController) {
        let tapGesture = UITapGestureRecognizer(target: target, action: #selector(UIView.handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
        self.tag = textField.hash // Use the text field's hash as a unique identifier
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        if let tappedView = sender.view,
           let parentView = tappedView.superview {
            // Find the associated UITextField using the tag
            if let textField = parentView.subviews.first(where: { $0.hash == tappedView.tag }) as? UITextField {
                textField.becomeFirstResponder()
            }
        }
    }
}


