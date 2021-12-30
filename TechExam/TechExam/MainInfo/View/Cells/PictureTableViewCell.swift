//
//  PictureTableViewCell.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 12/12/21.
//

import UIKit

protocol PictureTableViewCellDelegate: AnyObject {
  func goToImage()
}

final class PictureTableViewCell: UITableViewCell {
  static let reuseIdentifier = String(describing: PictureTableViewCell.self)
  
  weak var delegate: PictureTableViewCellDelegate?
  
  lazy var imageSelected: UIImageView = {
    let image = UIImageView()
    image.layer.borderWidth = 1
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  lazy var takePhotoButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .black
    button.setTitle("Add Picture", for: .normal)
    button.layer.cornerRadius = 12
    button.layer.borderWidth = 0.5
    button.addTarget(self, action: #selector(goToImages), for: .touchUpInside)
    return button
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    accessoryView = .none
    contentView.addSubview(imageSelected)
    contentView.addSubview(takePhotoButton)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    NSLayoutConstraint.activate([
      imageSelected.topAnchor.constraint(equalTo: topAnchor, constant: 30),
      imageSelected.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      imageSelected.widthAnchor.constraint(equalToConstant: 150),
      imageSelected.heightAnchor.constraint(equalToConstant: 150),
      
      takePhotoButton.topAnchor.constraint(equalTo: topAnchor, constant: 30),
      takePhotoButton.leadingAnchor.constraint(equalTo: imageSelected.trailingAnchor, constant: 16),
      takePhotoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      takePhotoButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  @objc func goToImages() {
    delegate?.goToImage()
  }
}
