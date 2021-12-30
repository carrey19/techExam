//
//  MainInfoPresenter.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 12/12/21.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase

protocol MainInfoPresenterDelegate: AnyObject {
  func showDataAlert()
  func showErrorSendingData()
  func changeBackGroundColor(newColor: String)
}

class MainInfoPresenter {
  // MARK: - Private Properties
  private let storage = Storage.storage().reference()

  // MARK: - Properties
  weak var delegate: MainInfoPresenterDelegate?
  var coordinator: MainInfoCoordinator
  let model = MainInfoModel()
  var image: UIImage?
  var name: String?
  var ref: DatabaseReference!

  // MARK: - Inits
  init(coordinator: MainInfoCoordinator) {
    ref = Database.database().reference()
    self.coordinator = coordinator
    detectChanges()
  }

  // MARK: - Methods
  func sendData() {
    guard let name = self.name, let image = self.image, let imageData = image.pngData() else {
      delegate?.showDataAlert()
      return
    }
    storage.child("\(name)/file.png").putData(imageData,
                                              metadata: nil,
                                              completion: { [weak self] _, error in
      guard error == nil else {
        self?.delegate?.showErrorSendingData()
        return
      }
    })
  }

  func goToGraphs() {
    coordinator.goToGraphs()
  }

  private func detectChanges() {
    ref.child("backgroundColor").observe(.value) { [weak self] snapshot in
      guard let color = snapshot.value as? String else {
        return
      }
      self?.delegate?.changeBackGroundColor(newColor: color)
    }
  }
}
