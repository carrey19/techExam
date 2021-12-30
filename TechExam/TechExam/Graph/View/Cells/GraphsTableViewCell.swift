//
//  GraphsTableViewCell.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 13/12/21.
//

import UIKit
import Charts

final class GraphsTableViewCell: UITableViewCell {
  static let reuseIdentifier = String(describing: GraphsTableViewCell.self)

  lazy var questionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 25, weight: .medium)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var graphView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 10
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    let bundle = Bundle(for: type(of: self))
    collectionView.register(OptionCollectionViewCell.self,
                            forCellWithReuseIdentifier: OptionCollectionViewCell.reuseIdentifier)
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .systemBackground
    collectionView.showsVerticalScrollIndicator = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
    collectionView.alwaysBounceVertical = true
    collectionView.delegate = self
    collectionView.dataSource = self
    return collectionView
  }()

  var pieChart = PieChartView()

  var question: QuestionViewData? {
    didSet {
      guard let question = question else { return }
      questionLabel.text = question.question
      confiureGraph(question: question)
      collectionView.reloadData()
    }
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    accessoryView = .none
    pieChart.delegate = self
    contentView.addSubview(questionLabel)
    contentView.addSubview(graphView)
    contentView.addSubview(collectionView)
    graphView.addSubview(pieChart)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    NSLayoutConstraint.activate([
      questionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      questionLabel.widthAnchor.constraint(equalToConstant: 250),

      graphView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 32),
      graphView.centerXAnchor.constraint(equalTo: centerXAnchor),
      graphView.widthAnchor.constraint(equalToConstant: 200),
      graphView.heightAnchor.constraint(equalToConstant: 200),

      collectionView.topAnchor.constraint(equalTo: graphView.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])

    pieChart.frame = CGRect(x: -50,
                            y: -50,
                            width: graphView.frame.size.width * 1.5,
                            height: graphView.frame.size.height * 1.5)
  }

  func confiureGraph(question: QuestionViewData) {
    var values = [ChartDataEntry]()
    var colors: [UIColor] = []

    for value in question.options {
      values.append(ChartDataEntry(x: Double(value.percent), y: Double(value.percent)))
      colors.append(value.color)
    }
    let set = PieChartDataSet(entries: values)
    set.colors = colors
    let data = PieChartData(dataSet: set)
    pieChart.data = data
  }
}

extension GraphsTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)) / 2
    return CGSize(width: itemSize, height: 30)
  }
}

extension GraphsTableViewCell: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    question?.options.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard
      let option = question?.options[indexPath.row],
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCollectionViewCell.reuseIdentifier,
                                                    for: indexPath) as? OptionCollectionViewCell
    else {
      return UICollectionViewCell()
    }
    cell.backgroundColor = .clear
    cell.option = option
    return cell
  }
}

extension GraphsTableViewCell: ChartViewDelegate {

}
