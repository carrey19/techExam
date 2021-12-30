//
//  GraphServicesManager.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 12/12/21.
//

import Foundation

typealias GraphResponse = APIResult<GraphModelResponse?>

struct GraphServicesManager {
  // MARK: - Private properties
  private let networking = Networking()
  
  // MARK: - Inits
  init() { }
  
  func getGraphsInfo(completion: @escaping GraphResponse) {
    let service = GraphRequest.getInfoGraphs
    networking.fetchService(service: service) { result in
      completion(result)
    }
  }
}
