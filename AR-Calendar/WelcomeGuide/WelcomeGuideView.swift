//
//  WelcomeGuideView.swift
//  AR-Calendar
//
//  Created by Denis Beloshitskiy
//

import Foundation
import SnapKit
import UIKit

final class WelcomeGuideView: UIView {
  // MARK: Inits
  
  convenience init(data: WelcomeGuideModel) {
    self.init(frame: .zero)
    setupView()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }

  // MARK: Setup functions

  private func setupView() {
    backgroundColor = .red
    setupLayout()
  }

  private func setupLayout() {
    
  }
}
