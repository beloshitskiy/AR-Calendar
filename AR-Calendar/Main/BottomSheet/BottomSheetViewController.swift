import SnapKit
import UIKit

public final class BottomSheetViewController: UIViewController {
  private let bottomSheetView = BottomSheetView()

  public override func viewDidLoad() {
    super.viewDidLoad()
    setupSubview()
  }

  private func setupSubview() {
    view.addSubview(aboutARView)
    aboutARView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }

  public func finishARGuide() {
    view.subviews[0].removeFromSuperview()

    view.addSubview(bottomSheetView)
    bottomSheetView.snp.makeConstraints { $0.edges.equalToSuperview() }
    view.layoutIfNeeded()
  }

  func updateBottomSheetContent(with month: MonthsModel.Month) {
    bottomSheetView.updateContent(with: month)
    view.layoutIfNeeded()
  }
}
