//
//  MainViewController.swift
//  AR-Calendar
//
//  Created by Denis Beloshitskiy
//

import ARKit
import Foundation
import SnapKit
import UIKit

final class MainViewController: UIViewController {
  let sceneView = ARSCNView()
  let bottomSheetVC = BottomSheetViewController()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubview()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    let configuration = ARImageTrackingConfiguration()

    if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "months images",
        bundle: Bundle.main) {
      configuration.trackingImages = trackedImages
      configuration.maximumNumberOfTrackedImages = 1
    }

    sceneView.session.run(configuration)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presentBottomSheet()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    sceneView.session.pause()
  }

  private func presentBottomSheet() {
    if let sheet = bottomSheetVC.sheetPresentationController {
      sheet.detents = [.custom { _ in 140.0 }]
      sheet.preferredCornerRadius = 25.0
      sheet.largestUndimmedDetentIdentifier = .medium
      sheet.prefersScrollingExpandsWhenScrolledToEdge = false
      sheet.prefersEdgeAttachedInCompactHeight = true
      sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
    }

    bottomSheetVC.isModalInPresentation = true
    present(bottomSheetVC, animated: true)
  }

  private func setupSubview() {
    sceneView.delegate = self

    view.addSubview(sceneView)
    sceneView.snp.makeConstraints { make in
      make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
      make.top.equalToSuperview()
    }
  }

  private func finishARGuide() {
    bottomSheetVC.finishARGuide()

    if let sheet = bottomSheetVC.sheetPresentationController {
      sheet.detents.append(.large())
    }
  }
}

extension MainViewController: ARSCNViewDelegate {
  // renderer(_, didAdd) is used when app recognizes a new month's image
  func renderer(_: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    guard let imageAnchor = anchor as? ARImageAnchor else {
      return
    }
    guard let month = imageAnchor.referenceImage.name else {
      return
    }

    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.4) {
        self.finishARGuide()
      }
    }

    let player = AVPlayer(playerItem: AVPlayerItem(url: Bundle.main.url(
      forResource: month, withExtension: "mp4", subdirectory: "months videos"
    )!))

    player.play()

    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                           object: player.currentItem, queue: nil) { _ in
      player.seek(to: CMTime.zero)
      player.play()
    }

    let videoNode = SKVideoNode(avPlayer: player)

    let videoScene = SKScene(size: CGSize(width: 2048, height: 1556))

    videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)

    videoNode.yScale = -1.0

    videoScene.addChild(videoNode)

    let physicalSize = imageAnchor.referenceImage.physicalSize

    let plane = SCNPlane(width: physicalSize.width, height: physicalSize.height)

    plane.firstMaterial?.diffuse.contents = videoScene

    let planeNode = SCNNode(geometry: plane)

    planeNode.eulerAngles.x = -Float.pi / 2

    node.addChildNode(planeNode)
  }

  /* renderer(_, didUpdate) is used when app recognizes the month's image,
   that has previously recognized  in order to update info */

  func renderer(_: SCNSceneRenderer, didUpdate _: SCNNode, for anchor: ARAnchor) {
    guard let imageAnchor = anchor as? ARImageAnchor else { return }
    guard let month = imageAnchor.referenceImage.name else { return }

    let data = DataLoader.loadMonthsData()

    guard let monthData = data.months[month] else { return }

    DispatchQueue.main.async {
      self.bottomSheetVC.updateBottomSheetContent(with: monthData)
    }
  }
}
