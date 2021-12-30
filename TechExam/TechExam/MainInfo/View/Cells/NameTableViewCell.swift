//
//  NameTableViewCell.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 12/12/21.
//

import UIKit

protocol NameTableViewCellDelegate: AnyObject {
  func sendName(name: String)
}

final class NameTableViewCell: UITableViewCell {
  static let reuseIdentifier = String(describing: NameTableViewCell.self)

  lazy var nameTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Name"
    textField.delegate = self
    textField.textAlignment = .center
    textField.layer.borderWidth = 0.5
    textField.layer.cornerRadius = 12
    textField.clearButtonMode = .whileEditing
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    accessoryView = .none
    contentView.addSubview(nameTextField)
  }

  weak var delegate: NameTableViewCellDelegate?

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    NSLayoutConstraint.activate([
      nameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
      nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      nameTextField.heightAnchor.constraint(equalToConstant: 50),
      nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
      nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
    ])
  }
}

extension NameTableViewCell: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if let _ = string.rangeOfCharacter(from: NSCharacterSet.letters) {
      return true
    }
    else {
      return false
    }
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let name = textField.text else { return }
    delegate?.sendName(name: name)
  }
}
