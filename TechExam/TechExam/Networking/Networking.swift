//
//  Networking.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 12/12/21.
//

import Foundation

typealias APIResult<T> = (Result<T,NetworkError>) -> Void

class Networking {
  // MARK: - Inits
  init() { }

  // MARK: - Handlers
  func fetchService(service: RequestProtocol, completion: @escaping GraphResponse) {
    let request = makeRequest(service: service)
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
      // Validation of task error
      if let sesionError = error {
        completion(.failure(NetworkError.errorForParseFailed(error: sesionError.localizedDescription)))
        return
      }
      guard let responseData = data, let json = try? JSONSerialization.jsonObject(with: responseData, options: []) else {
        completion(.failure(NetworkError.errorForWrongStructure()))
        return
      }
      completion(ParserHelper.parseObject(of: GraphModelResponse?.self, data: json))
    }.resume()
  }

  func makeRequest(service: RequestProtocol) -> URLRequest {
    var request = URLRequest(url: service.baseURL.appendingPathComponent(service.path),
                             cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                             timeoutInterval: service.timeoutInterval)
    request.httpMethod = service.method.rawValue
    for header in service.headers.collection {
      request.setValue(header.value, forHTTPHeaderField: header.key.rawValue)
    }
    switch service.method {
    case .delete, .post:
      guard let httpBody = try? JSONSerialization.data(withJSONObject: service.parameters, options: []) else {
        return request
      }
      request.httpBody = httpBody
    case .get:
      return request
    }

    if let url = request.url, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !service.parameters.isEmpty {

      urlComponents.queryItems = [URLQueryItem]()
      for (key,value) in service.parameters {
        let queryItem = URLQueryItem(name: key,
                                     value: "\(value)")
        urlComponents.queryItems?.append(queryItem)
      }
      request.url = urlComponents.url
    }

    return request
  }
}
