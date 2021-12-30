//
//  MainInfoViewController.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 12/12/21.
//

import UIKit
import Foundation

class MainInfoViewController: UIViewController, UINavigationControllerDelegate {
  // MARK: - Private Properties
  private lazy var tableView: UITableView = {
    let tableView = AutosizingTableView()
    tableView.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.reuseIdentifier)
    tableView.register(PictureTableViewCell.self, forCellReuseIdentifier: PictureTableViewCell.reuseIdentifier)
    tableView.register(GraphTableViewCell.self, forCellReuseIdentifier: GraphTableViewCell.reuseIdentifier)
    tableView.register(SendPictureTableViewCell.self, forCellReuseIdentifier: SendPictureTableViewCell.reuseIdentifier)
    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    tableView.showsVerticalScrollIndicator = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorStyle = .none
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = .clear
    return tableView
  }()
  private var presenter: MainInfoPresenter?
  private var imagePicker: UIImagePickerController?
  private enum ImageSource {
    case photoLibrary
    case camera
  }
  private enum Constants {
    static let defaultCellheight = 50.0
    static let case1Cellheight = 200.0
    static let numberOfRowsInSection = 4
  }

  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupConstraints()
  }

  // MARK: - Private Methods
  private func setup() {
    presenter = MainInfoPresenter(coordinator: MainInfoCoordinator(navigationController:
                                                                    self.navigationController))
    self.title = presenter?.model.title
    presenter?.delegate = self
    self.hideKeyboardWhenTappedAround()
    view.backgroundColor = .white
    view.addSubview(tableView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
    ])
  }

  private func selectImageFrom(_ source: ImageSource) {
    imagePicker =  UIImagePickerController()
    imagePicker?.delegate = self
    switch source {
    case .camera:
      imagePicker?.sourceType = .camera
    case .photoLibrary:
      imagePicker?.sourceType = .photoLibrary
    }
    guard let imagePicker = imagePicker else { return }
    present(imagePicker, animated: true, completion: nil)
  }

  // MARK: - Methods
  func showAlert() {
    let alert = UIAlertController(title: presenter?.model.imageAlertTitle, message: presenter?.model.imageAlertMessage, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: presenter?.model.cameraButton, style: .default, handler: {(action: UIAlertAction) in
      self.selectImageFrom(.camera)
    }))
    alert.addAction(UIAlertAction(title: presenter?.model.photoAlbumButton, style: .default, handler: {(action: UIAlertAction) in
      self.selectImageFrom(.photoLibrary)
    }))
    alert.addAction(UIAlertAction(title: presenter?.model.cancelButton, style: .destructive, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}

// MARK: - UITableViewDelegate
extension MainInfoViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
    case 1:
      return Constants.case1Cellheight
    default:
      return Constants.defaultCellheight
    }
  }
}

// MARK: - UITableViewDataSource
extension MainInfoViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    Constants.numberOfRowsInSection
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      guard
        let cell = tableView.dequeueReusableCell(withIdentifier: NameTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? NameTableViewCell else {
          return UITableViewCell()
        }
      cell.delegate = self
      cell.backgroundColor = .clear
      return cell
    case 1:
      guard
        let cell = tableView.dequeueReusableCell(withIdentifier: PictureTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? PictureTableViewCell else {
          return UITableViewCell()
        }
      cell.imageSelected.image = presenter?.image
      cell.delegate = self
      cell.backgroundColor = .clear
      return cell
    case 2:
      guard
        let cell = tableView.dequeueReusableCell(withIdentifier: GraphTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? GraphTableViewCell else {
          return UITableViewCell()
        }
      cell.delegate = self
      cell.backgroundColor = .clear
      return cell
    case 3:
      guard
        let cell = tableView.dequeueReusableCell(withIdentifier: SendPictureTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? SendPictureTableViewCell else {
          return UITableViewCell()
        }
      cell.backgroundColor = .clear
      cell.delegate = self
      return cell
    default:
      return UITableViewCell()
    }
  }
}

// MARK: - PictureTableViewCellDelegate
extension MainInfoViewController: PictureTableViewCellDelegate {
  func goToImage() {
    showAlert()
  }
}

// MARK: - GraphTableViewCellDelegate
extension MainInfoViewController: GraphTableViewCellDelegate {
  func goToGraph() {
    presenter?.goToGraphs()
  }
}

// MARK: - NameTableViewCellDelegate
extension MainInfoViewController: NameTableViewCellDelegate {
  func sendName(name: String) {
    presenter?.name = name
  }
}

// MARK: - SendPictureTableViewCellDelegate
extension MainInfoViewController: SendPictureTableViewCellDelegate {
  func sendData() {
    presenter?.sendData()
  }
}

// MARK: - UIImagePickerControllerDelegate
extension MainInfoViewController: UIImagePickerControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
    imagePicker?.dismiss(animated: true, completion: nil)
    guard let selectedImage = info[.originalImage] as? UIImage else {
      print("Image not found!")
      return
    }
    presenter?.image = selectedImage
    tableView.reloadData()
  }
}

// MARK: - MainInfoPresenterDelegate
extension MainInfoViewController: MainInfoPresenterDelegate {
  func changeBackGroundColor(newColor: String) {
    DispatchQueue.main.async {
      self.view.backgroundColor = UIColor(hex: newColor)
      self.view.reloadInputViews()
    }
  }

  func showDataAlert() {
    let alert = UIAlertController(title: presenter?.model.alertTitle, message: presenter?.model.dataAlertMessage, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: presenter?.model.okAlertTitle, style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }

  func showErrorSendingData() {
    let alert = UIAlertController(title: presenter?.model.alertTitle, message: presenter?.model.errorAlertMessage, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: presenter?.model.okAlertTitle, style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
