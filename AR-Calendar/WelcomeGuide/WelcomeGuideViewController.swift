//
//  WelcomeGuideViewController.swift
//  AR-Calendar
//
//  Created by Denis Beloshitskiy
//

import Foundation
import HandlersKit
import SnapKit
import UIKit

final class WelcomeGuideViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(named: "DarkGray")

    let data = DataLoader.loadGuideData(guideDataPath)

    let welcomeGuideView = WelcomeGuideView(data)
    
    view.addSubview(welcomeGuideView)
    view.addSubview(continueButton)

    welcomeGuideView.snp.makeConstraints { make in
      make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
      make.bottom.equalTo(continueButton.snp.top).offset(-30)
    }
    
    continueButton.snp.makeConstraints { make in
      make.width.equalTo(175)
      make.height.equalTo(45)
      make.centerX.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
    }
  }
  
  private func completeGuide() {
    UserDefaults.standard.set(true, forKey: "isGuideCompleted")
    
    let mainController = MainViewController()
    mainController.modalPresentationStyle = .fullScreen
    
    let transition = CATransition()
    transition.duration = 0.3
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromBottom
    guard let window = view.window else { return }
    window.layer.add(transition, forKey: kCATransition)
    
    present(mainController, animated: false, completion: nil)
  }
  
  private lazy var continueButton: UIButton = {
    let button = UIButton(type: .system)
    
    var buttonText = AttributedString("Продолжить")
    buttonText.font = .systemFont(ofSize: 19, weight: .bold)
    
    var config = UIButton.Configuration.filled()
    config.cornerStyle = .medium
    config.attributedTitle = buttonText
    config.baseForegroundColor = UIColor(named: "DarkGray")
    config.baseBackgroundColor = UIColor(named: "LightGray")

    button.configuration = config
    
    button.onTap {
      self.completeGuide()
    }
    
    return button
  }()
}

private let guideDataPath = "welcomeGuideData.json"
