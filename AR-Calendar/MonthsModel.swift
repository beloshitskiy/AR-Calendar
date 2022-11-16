//
//  MonthsModel.swift
//  AR-Calendar
//
//  Created by Denis Beloshitskiy
//

public struct MonthsModel {
  let months: [String: Month]

  struct Month: Decodable {
    let title: String
    let mainTextBlock: String
    let imageTextBlock: String
  }
}
