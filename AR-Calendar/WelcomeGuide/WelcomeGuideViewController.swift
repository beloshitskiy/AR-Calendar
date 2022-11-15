//
//  WelcomeGuideViewContoller.swift
//  AR-Calendar
//
//  Created by Denis Beloshitskiy
//

import Foundation
import SnapKit
import UIKit

final class WelcomeGuideViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    let data = DataLoader.loadGuideData(guideDataPath)

    let welcomeGuideView = WelcomeGuideView(data)
    
    view.addSubview(welcomeGuideView)
    view.backgroundColor = UIColor(named: "DarkGray")

    welcomeGuideView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func completeGuide() {
    UserDefaults.standard.set(true, forKey: "isGuideCompleted")
    
    let mainController = MainViewController()
    mainController.modalPresentationStyle = .fullScreen
    
    let transition = CATransition()
    transition.duration = 0.3
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromRight
    guard let window = view.window else { return }
    window.layer.add(transition, forKey: kCATransition)
    
    present(mainController, animated: true, completion: nil)
  }
}

private let guideDataPath = "welcomeGuideData.json"
