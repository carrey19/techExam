//
//  OptionCollectionViewCell.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 13/12/21.
//

import UIKit

final class OptionCollectionViewCell: UICollectionViewCell {

  static let reuseIdentifier = String(describing: OptionCollectionViewCell.self)

  lazy var colorView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 10
    view.backgroundColor = .purple
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  lazy var percentLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .medium)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(colorView)
    contentView.addSubview(percentLabel)
  }

  var option: OptionsViewData? {
    didSet {
      guard let option = option else { return }
      colorView.backgroundColor = option.color
      percentLabel.text = "\(option.option) \(option.percent)%"
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    NSLayoutConstraint.activate([
      colorView.centerYAnchor.constraint(equalTo: centerYAnchor),
      colorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      colorView.widthAnchor.constraint(equalToConstant: 30),
      colorView.heightAnchor.constraint(equalToConstant: 30),

      percentLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 8),
      percentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      percentLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
