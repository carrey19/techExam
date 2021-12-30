//
//  GraphTableViewCell.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 12/12/21.
//

import UIKit

protocol GraphTableViewCellDelegate: AnyObject {
  func goToGraph()
}

final class GraphTableViewCell: UITableViewCell {
  static let reuseIdentifier = String(describing: GraphTableViewCell.self)
  
  weak var delegate: GraphTableViewCellDelegate?
  
  lazy var descriptionButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .black
    button.layer.cornerRadius = 12
    button.layer.borderWidth = 0.5
    button.setTitle("Go to Graphs", for: .normal)
    button.addTarget(self, action: #selector(goToGraphs), for: .touchUpInside)
    return button
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    accessoryView = .none
    contentView.addSubview(descriptionButton)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    NSLayoutConstraint.activate([
      descriptionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      descriptionButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      descriptionButton.heightAnchor.constraint(equalToConstant: 40),
      descriptionButton.widthAnchor.constraint(equalToConstant: 200)
    ])
  }
  
  @objc func goToGraphs() {
    delegate?.goToGraph()
  }
}
