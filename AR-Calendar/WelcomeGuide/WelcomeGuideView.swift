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
  let model: WelcomeGuideModel?
  
  // MARK: - Inits
  
  init(_ data: WelcomeGuideModel) {
    model = data
    super.init(frame: UIScreen.main.bounds)
    setupView()
    setupLayout()
  }
  
  override init(frame: CGRect) {
    model = nil
    super.init(frame: frame)
    setupView()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    model = nil
    super.init(coder: coder)
    setupView()
    setupLayout()
  }
  
  // MARK: - Setup functions
  
  private func setupView() {
    addSubview(headerView)
    addSubview(stackView)
    setupLayout()
  }
  
  private func setupLayout() {
    headerView.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
    
    stackView.snp.makeConstraints { make in
      make.top.equalTo(headerView).offset(45)
      make.bottom.equalToSuperview()
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
  }
  
  // MARK: - HeaderView
  
  private lazy var headerView: UILabel = {
    let header = UILabel()
    
    header.text = "Добро пожаловать!"
    header.numberOfLines = 1
    header.font = .systemFont(ofSize: 34, weight: .bold)
    header.contentMode = .left
    header.textColor = UIColor(named: "LightGray")
    
    return header
  }()
  
  // MARK: - StackView
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    stackView.alignment = .leading
    stackView.contentMode = .scaleToFill
    
    if let blocks = model?.textBlocks {
      for dataBlock in blocks {
        let view = createTextBlockView(from: dataBlock)
        stackView.addArrangedSubview(view)
        
        view.snp.makeConstraints { make in
          make.horizontalEdges.equalTo(stackView)
        }
      }
    }
    return stackView
  }()
  
  private func createTextBlockView(from block: WelcomeGuideTextBlock) -> UIView {
    let view = UIView()

    let textView = UITextView()
    textView.text = String(block.id) + ". " + block.description
    
    textView.isEditable = false
    textView.backgroundColor = .clear
    textView.isScrollEnabled = false
    textView.contentMode = .left
    textView.showsVerticalScrollIndicator = false
    
    textView.attributedText = NSAttributedString.makeHyperLink(for: WelcomeGuideTextBlock.staticURL,
                                                               in: textView.text,
                                                               as: "по ссылке")
    
    textView.textColor = UIColor(named: "LightGray")
    textView.font = .boldSystemFont(ofSize: 17)
    textView.tintColor = .link
    
    view.addSubview(textView)
    
    if let imageName = block.imageName {
      let imageView = UIImageView(image: UIImage(named: imageName))
      imageView.contentMode = .scaleAspectFit
      view.addSubview(imageView)
      
      textView.snp.makeConstraints { make in
        make.leading.centerY.equalToSuperview()
      }
      
      imageView.snp.makeConstraints { make in
        make.size.equalTo(50)
        make.leading.equalTo(textView.snp.trailing).offset(20)
        make.trailing.centerY.equalToSuperview()
      }
    } else {
      textView.snp.makeConstraints { make in
        make.horizontalEdges.centerY.equalToSuperview()
      }
    }
    
    return view
  }
}
