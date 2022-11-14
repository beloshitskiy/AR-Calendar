//
//  WelcomeGuideModel.swift
//  AR-Calendar
//
//  Created by Denis Beloshitskiy
//

// represents a text block, which is shown on the WelcomeGuide page
struct WelcomeGuideModel {
  let textBlocks: [WelcomeGuideTextBlock]

  struct WelcomeGuideTextBlock: Decodable, Identifiable {
    let id: Int
    let description: String
    let imageName: String?
  }
}
