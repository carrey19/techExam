//
//  GraphResponseModel.swift
//  TechExam
//
//  Created by Juan Carlos  Carrera on 12/12/21.
//

import UIKit

struct GraphModelResponse: Decodable {
    let colors: [String]
    let questions: [QuestionResponseModel]
}

struct QuestionResponseModel: Decodable {
    let total: Int
    let text: String
    let chartData: [ChartDataResponseModel]
}

struct ChartDataResponseModel: Decodable {
    let text: String
    let percetnage: Int
}

extension QuestionResponseModel {
    func mapToModel() -> Question {
        Question(total: total,
                 text: text,
                 chartData: chartData.map { $0.mapToModel() } )
    }
}

extension ChartDataResponseModel {
    func mapToModel() -> ChartData {
        ChartData(text: text,
                  percetnage: percetnage)
    }
}

struct Question {
    let total: Int
    let text: String
    let chartData: [ChartData]
}

struct ChartData {
    let text: String
    let percetnage: Int
}

extension Question {
    func mapToViewData() -> QuestionViewData {
        return QuestionViewData(question: text,
                                options: chartData.map { $0.mapToViewData() })
    }
}

extension ChartData {
    func mapToViewData() -> OptionsViewData {
        OptionsViewData(color: .clear,
                        option: text,
                        percent: percetnage)
    }
}

struct QuestionViewData {
    let question: String
    let options: [OptionsViewData]
}

struct OptionsViewData {
    let color: UIColor
    let option: String
    let percent: Int
}
