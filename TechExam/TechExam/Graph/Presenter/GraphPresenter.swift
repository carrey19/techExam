//
//  GraphPresenter.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 13/12/21.
//

import UIKit
import FirebaseDatabase

protocol GraphPresenterDelegate: AnyObject {
  func display(questions: [QuestionViewData])
  func showActivityView()
  func hideActivityView()
  func changeBackGroundColor(newColor: String)
}

final class GraphPresenter {
  // MARK: - Private Properties
  private var coordinator: GraphCoordinator
  private let networkManager = GraphServicesManager()
  // MARK: - Properties
  let model = GraphModel()
  var questions: [Question] = []
  weak var delegate: GraphPresenterDelegate?
  var ref: DatabaseReference!

  // MARK: - Inits
  init(coordinator: GraphCoordinator) {
    ref = Database.database().reference()
    self.coordinator = coordinator
  }

  // MARK: - Methods
  func getInfoGraphs() {
    delegate?.showActivityView()
    networkManager.getGraphsInfo { [weak self] result in
      switch result {
      case .success(let response):
        guard let self = self else { return }
        guard let questionsReceived = response?.questions else { return }
        guard let colors = response?.colors else { return }
        self.questions = questionsReceived.map { $0.mapToModel() }
        
        var questionsToShow: [QuestionViewData] = []
        
        for question in self.questions {
          let options = question.chartData.enumerated().map { (index, option) in
            OptionsViewData(color: UIColor(hex: colors[index]) ,
                            option: option.text,
                            percent: option.percetnage)
          }
          questionsToShow.append(QuestionViewData(question: question.text,
                                                  options: options))
          
        }
        self.delegate?.hideActivityView()
        self.delegate?.display(questions: questionsToShow)
      case .failure(_):
        self?.delegate?.hideActivityView()
      }
    }
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
