//
//  MainInfoCoordinator.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 12/12/21.
//

import Foundation
import UIKit


class MainInfoCoordinator {
  var navigationContoller: UINavigationController?

  init(navigationController: UINavigationController?) {
    self.navigationContoller = navigationController
  }

  func goToGraphs() {
    guard let navigationContoller = navigationContoller else { return }
    let graphCoordinator = GraphCoordinator(navigationController: navigationContoller)
    graphCoordinator.start()
  }
}
