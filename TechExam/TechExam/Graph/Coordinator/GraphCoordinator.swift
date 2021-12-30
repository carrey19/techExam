//
//  GraphCoordinator.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 13/12/21.
//

import Foundation
import UIKit

class GraphCoordinator {
  var navigationController: UINavigationController?
  var graphViewController: GraphViewController?

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    let presenter = GraphPresenter(coordinator: self)
    graphViewController = GraphViewController(presenter: presenter)
  }

  func start() {
    guard let graphViewController = graphViewController else { return }
    navigationController?.pushViewController(graphViewController, animated: true)
  }
}
