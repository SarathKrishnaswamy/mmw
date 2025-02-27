//
//  AlertUtils.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 20/02/25.
//

import Foundation
import UIKit

class AlertUtils {
    static func showAlert(title: String,
                          message: String,
                          on viewController: UIViewController,
                          actionTitle: String = "OK",
                          actionHandler: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            actionHandler?()
        }
        alert.addAction(action)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    static func showAlertTwoButtons(title: String,
                          message: String,
                          on viewController: UIViewController,
                          primaryActionTitle: String = "OK",
                          secondaryActionTitle: String = "Cancel",
                          primaryActionHandler: (() -> Void)? = nil,
                          secondaryActionHandler: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let primaryAction = UIAlertAction(title: primaryActionTitle, style: .default) { _ in
            primaryActionHandler?()
        }
        
        let secondaryAction = UIAlertAction(title: secondaryActionTitle, style: .cancel) { _ in
            secondaryActionHandler?()
        }
        
        alert.addAction(primaryAction)
        alert.addAction(secondaryAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}

