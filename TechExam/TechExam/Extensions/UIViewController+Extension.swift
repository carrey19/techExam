//
//  UIViewController+Extension.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 12/12/21.
//

import UIKit

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    DispatchQueue.main.async {
      self.view.endEditing(true)
    }
  }
}
