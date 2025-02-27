//
//  ActivityIndicatorManager.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 20/02/25.
//

import Foundation
import UIKit

// MARK: - Activity Indicator Manager
class ActivityIndicatorManager {
    static let shared = ActivityIndicatorManager()
    private var backgroundView: UIView?
    private var containerView: UIView?
    private var activityIndicator: UIActivityIndicatorView?
    
    private init() {
            setupActivityIndicator()
        }
    
    /// **Setup the activity indicator overlay** (Automatically called when `startAnimating()` is triggered)
      private func setupActivityIndicator() {
          guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) else {
              print("⚠️ Unable to find key window for Activity Indicator")
              return
          }
          
          if backgroundView == nil {
              let bgView = UIView(frame: keyWindow.bounds)
              bgView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
              bgView.isHidden = true
              
              let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
              containerView.center = keyWindow.center
              containerView.backgroundColor = UIColor.white
              containerView.layer.cornerRadius = 10
              
              let indicator = UIActivityIndicatorView(style: .large)
              indicator.color = UIColor.accent
              indicator.center = CGPoint(x: containerView.bounds.midX, y: containerView.bounds.midY)
              
              containerView.addSubview(indicator)
              bgView.addSubview(containerView)
              keyWindow.addSubview(bgView)
              
              self.backgroundView = bgView
              self.containerView = containerView
              self.activityIndicator = indicator
          }
      }
    
    func startAnimating() {
        DispatchQueue.main.async {
            self.backgroundView?.isHidden = false
            self.activityIndicator?.startAnimating()
        }
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            self.backgroundView?.isHidden = true
        }
    }
}
