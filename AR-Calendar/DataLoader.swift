//
//  DataLoader.swift
//  AR-Calendar
//
//  Created by Denis Beloshitskiy
//

import Foundation

final class DataLoader {
  static func loadGuideData(_ filename: String) -> WelcomeGuideModel {
    WelcomeGuideModel(textBlocks: loadData(filename))
  }

  static func loadMonthsData(_ filename: String) -> MonthsModel {
    MonthsModel(months: loadData(filename))
  }

  private static func loadData<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
      fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
      data = try Data(contentsOf: file)
    } catch {
      fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
      let decoder = JSONDecoder()
      return try decoder.decode(T.self, from: data)
    } catch {
      fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
  }
}
