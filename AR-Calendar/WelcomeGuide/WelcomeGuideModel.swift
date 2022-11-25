// represents a text block, which is shown on the WelcomeGuide page
struct WelcomeGuideModel {
  let textBlocks: [WelcomeGuideTextBlock]
}

struct WelcomeGuideTextBlock: Decodable, Identifiable {
  let id: Int
  let description: String
  let imageName: String?
  static var staticURL = "https://github.com/meinkognito/AR-Calendar/raw/master/calendar.pdf"
}
