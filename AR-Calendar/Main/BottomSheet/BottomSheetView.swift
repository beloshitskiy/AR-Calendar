import SnapKit
import UIKit

final class BottomSheetView: UIStackView {
  convenience init() {
    self.init(frame: .zero)
    [aboutImageView, aboutIETView].forEach { self.addArrangedSubview($0) }
    setupConstraints()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  @available(*, unavailable)
  required init(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func updateContent(with month: MonthsModel.Month) {
    guard let title = aboutImageView.subviews[1] as? UILabel,
          let imageTextBlock = aboutImageView.subviews[2] as? UITextView,
          let mainTextBlock = aboutIETView.subviews[1] as? UITextView,
          title.text != month.title,
          imageTextBlock.text != month.imageTextBlock,
          mainTextBlock.text != month.mainTextBlock else { return }

    title.text = month.title
    imageTextBlock.text = month.imageTextBlock
    mainTextBlock.text = month.mainTextBlock
  }

  private func setupConstraints() {
    aboutImageView.snp.makeConstraints { make in
      make.top.horizontalEdges.equalToSuperview()
//      make.bottom.equalTo(self.snp.center)
    }
    aboutIETView.snp.makeConstraints { make in
      make.top.equalTo(aboutImageView)
      make.bottom.horizontalEdges.equalToSuperview()
    }
  }

  private let aboutImageView: UIView = {
    let view = UIView()
    view.backgroundColor = Colors.lightGray

    let imageView = UIImageView(image: UIImage(named: "infoIcon"))
    imageView.contentMode = .scaleAspectFit

    let infoImageTitle = UILabel()
    infoImageTitle.numberOfLines = 0
    infoImageTitle.font = .boldSystemFont(ofSize: 18)
    infoImageTitle.textColor = Colors.darkGray

    let infoImageTextView = UITextView()
    infoImageTextView.font = .systemFont(ofSize: 16)
    infoImageTextView.backgroundColor = .clear
    infoImageTextView.textColor = Colors.darkGray
    infoImageTextView.contentMode = .left
    infoImageTextView.showsVerticalScrollIndicator = false
    infoImageTextView.isEditable = false
    infoImageTextView.isScrollEnabled = false

    [imageView, infoImageTitle, infoImageTextView].forEach { view.addSubview($0) }

    imageView.snp.makeConstraints { make in
      make.size.equalTo(50)
      make.top.equalToSuperview().offset(20)
      make.leading.equalToSuperview().offset(20)
    }

    infoImageTitle.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }

    infoImageTextView.snp.makeConstraints { make in
      make.top.equalTo(infoImageTitle.snp.bottom)
      make.leading.equalTo(imageView.snp.trailing).offset(10)
      make.trailing.equalToSuperview().offset(-20)
    }

    return view
  }()

  private let aboutIETView: UIView = {
    let view = UIView()
    view.backgroundColor = Colors.darkGray

    let ietImageView = UIImageView(image: UIImage(named: "IETIcon"))
    ietImageView.contentMode = .scaleAspectFit

    let ietTextView = UITextView()
    ietTextView.textColor = Colors.lightGray
    ietTextView.font = .systemFont(ofSize: 16)
    ietTextView.backgroundColor = .clear
    ietTextView.contentMode = .left
    ietTextView.showsVerticalScrollIndicator = false
    ietTextView.isEditable = false

    [ietImageView, ietTextView].forEach { view.addSubview($0) }

    ietImageView.snp.makeConstraints { make in
      make.size.equalTo(50)
      make.leading.top.equalToSuperview().offset(20)
    }

    ietTextView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.leading.equalTo(ietImageView.snp.trailing).offset(5)
      make.trailing.bottom.equalToSuperview().offset(20)
    }

    return view
  }()
}

var aboutARView: UIView = {
  let view = UIView()
  view.backgroundColor = Colors.lightGray
  view.layer.cornerRadius = 25

  let label = UILabel()
  label.text = "Наведите камеру на изображение календаря"
  label.textAlignment = .center
  label.textColor = Colors.darkGray
  label.backgroundColor = .clear
  label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
  label.numberOfLines = 2

  view.addSubview(label)
  label.snp.makeConstraints { $0.horizontalEdges.centerY.equalToSuperview() }

  return view
}()
