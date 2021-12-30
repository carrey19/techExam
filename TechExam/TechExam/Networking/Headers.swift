//
//  Headers.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 12/12/21.
//

import Foundation

struct Headers: Subscriptable {
  
  var collection: [HeaderName: String] = [:]
  
  init() {}
  
  subscript(index: HeaderName) -> String {
    get { return collection[index] ?? "" }
    set { collection[index] = newValue }
  }
}

enum HeaderName: String, Hashable {
  case contentType      = "Content-Type"
  case authorization = "Authorization"
}
