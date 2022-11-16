//
//  WelcomeGuideViewController.swift
//  AR-Calendar
//
//  Created by Denis Beloshitskiy
//

import HandlersKit
import SnapKit
import UIKit

final class WelcomeGuideViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
  }
  
  private func setupSubviews() {
    view.backgroundColor = Colors.darkGray
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
    transition.subtype = CATransitionSubtype.fromRight
    guard let window = view.window else { return }
    window.layer.add(transition, forKey: kCATransition)
    
    present(mainController, animated: false, completion: nil)
  }
  
  private lazy var welcomeGuideView: WelcomeGuideView = {
    let data = DataLoader.loadGuideData()
    let view = WelcomeGuideView(data)
    return view
  }()
  
  private lazy var continueButton: UIButton = { [weak self] in
    let button = UIButton(type: .system)
    
    var buttonText = AttributedString("Продолжить")
    buttonText.font = .systemFont(ofSize: 19, weight: .bold)
    
    var config = UIButton.Configuration.filled()
    config.cornerStyle = .medium
    config.attributedTitle = buttonText
    config.baseForegroundColor = Colors.darkGray
    config.baseBackgroundColor = Colors.lightGray

    button.configuration = config
    
    button.onTap {
      self?.completeGuide()
    }
    
    return button
  }()
}
