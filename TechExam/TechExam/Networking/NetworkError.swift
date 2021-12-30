//
//  NetworkError.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 12/12/21.
//

import Foundation

public struct NetworkError: Error, LocalizedError {

  private static let defaultErrorCode = "API_ERROR"
  private static let defaultErrorType = "internal"

  let code: String
  let type: String
  let error: String
  let httpCode: Int
  let jsonResponse: [String:Any]?

  public var errorDescription: String? {
    return (error == "" ? code : error)
  }

  static func errorForRecuestfailed() -> NetworkError {
    return NetworkError(code: defaultErrorCode, type: defaultErrorType, error: "urlRequest failed.",httpCode: 500, jsonResponse: nil)
  }

  static func errorForWrongStructure() -> NetworkError {
    return NetworkError(code: defaultErrorCode, type: defaultErrorType, error: "wrong structure",httpCode: 500, jsonResponse: nil)
  }

  static func errorForParseFailed(error: String) -> NetworkError {
    return NetworkError(code: defaultErrorCode, type: defaultErrorType, error: error,httpCode: 500, jsonResponse: nil)
  }
  
  static func errorWithMessage(_ message:String) -> NetworkError {
    return NetworkError(code: defaultErrorCode, type: defaultErrorType, error: message,httpCode: 500, jsonResponse: nil)
  }

  static func errorReadingFile() -> NetworkError {
    return NetworkError(code: defaultErrorCode, type: defaultErrorType, error: "errorReadingFile.",httpCode: 500, jsonResponse: nil)
  }
}
