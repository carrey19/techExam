//
//  GraphViewController.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 13/12/21.
//

import UIKit

final class GraphViewController: UIViewController {
  // MARK: - Private Properties
  private var activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
  private lazy var tableView: UITableView = {
    let tableView = AutosizingTableView()
    tableView.register(GraphsTableViewCell.self, forCellReuseIdentifier: GraphsTableViewCell.reuseIdentifier)
    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    tableView.showsVerticalScrollIndicator = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorStyle = .none
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = .clear
    return tableView
  }()
  private enum Constants {
    static let defaultCellheight = 400.0
  }
  // MARK: - Properties
  var questions: [QuestionViewData] = []
  let presenter: GraphPresenter

  // MARK: - Inits
  init(presenter: GraphPresenter) {
    self.presenter = presenter
    super.init(nibName: nil,
               bundle: Bundle(for: type(of: self)))
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life Cycle
  override func loadView() {
    super.loadView()
    view.backgroundColor = .white
    view.addSubview(tableView)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.getInfoGraphs()
    overrideUserInterfaceStyle = .unspecified
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupConstraints()
  }

  // MARK: - Private Methods
  private func setup() {
    activityView.translatesAutoresizingMaskIntoConstraints = false
    tableView.addSubview(activityView)
    presenter.delegate = self
    self.title = presenter.model.title
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      // Table view
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      // Activity view
      activityView.widthAnchor.constraint(equalToConstant: 50),
      activityView.heightAnchor.constraint(equalToConstant: 50),
      activityView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      activityView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
    ])
  }
}

// MARK: - UITableViewDelegate
extension GraphViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    Constants.defaultCellheight
  }
}

// MARK: - UITableViewDataSource
extension GraphViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    questions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(withIdentifier: GraphsTableViewCell.reuseIdentifier,
                                               for: indexPath) as? GraphsTableViewCell
    else {
      return UITableViewCell()
    }
    cell.backgroundColor = .clear
    cell.question = questions[indexPath.row]
    return cell
  }
}

// MARK: - GraphPresenterDelegate
extension GraphViewController: GraphPresenterDelegate {
  func changeBackGroundColor(newColor: String) {
    DispatchQueue.main.async {
      self.view.backgroundColor = UIColor(hex: newColor)
      self.view.reloadInputViews()
    }
  }

  func display(questions: [QuestionViewData]) {
    self.questions = questions
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  func showActivityView() {
    DispatchQueue.main.async {
      self.activityView.isHidden = false
      self.activityView.startAnimating()
    }
  }

  func hideActivityView() {
    DispatchQueue.main.async {
      self.activityView.isHidden = true
      self.activityView.stopAnimating()
    }
  }
}
