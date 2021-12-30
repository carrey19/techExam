//
//  Subscriptable.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 12/12/21.
//

import Foundation

protocol Subscriptable {
  associatedtype Name: Hashable
  subscript(index: Name) -> String { get set }
}
