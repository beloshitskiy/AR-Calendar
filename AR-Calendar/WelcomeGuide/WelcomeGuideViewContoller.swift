//
//  WelcomeGuideViewContoller.swift
//  AR-Calendar
//
//  Created by Denis Beloshitskiy
//

import Foundation
import SnapKit
import UIKit

final class WelcomeGuideViewContoller: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    let data = DataLoader.loadGuideData(guideDataPath)

    let welcomeGuideView = WelcomeGuideView(data: data)
    view.addSubview(welcomeGuideView)

    welcomeGuideView.snp.makeConstraints { make in
      make.center.equalTo(view)
    }
  }
}

private let guideDataPath = "welcomeGuideData.json"
