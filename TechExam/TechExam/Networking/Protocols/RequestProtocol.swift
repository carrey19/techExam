//
//  RequestProtocol.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 12/12/21.
//

import Foundation

/// Defines methods for RequestProtocol compatibility.
/// Concrete Request Services can implement it to add `RequestProtocol` compatiblity.
protocol RequestProtocol {
  /// An baseURL String
  var baseURL: URL { get }
  /// Path of specific service to request
  var path: String { get }
  /// `headers` required to make the `URLRequest` of an specific Service or API.
  var headers: Headers { get }
  /// `HTTP Method GET-POST-DELETE` required to make the `URLRequest` of an specific Service or API.
  var method: HTTPMethod { get }
  /// `TimeInterval` for obtaining request data.
  var timeoutInterval: TimeInterval { get }
  /// `Parameters` required to make the `URLRequest` of an specific Service or API.
  var parameters: [String: Any] { get }
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case delete = "DELETE"
}
