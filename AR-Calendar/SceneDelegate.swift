import UIKit

internal class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo _: UISceneSession,
    options _: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    let window = UIWindow(windowScene: windowScene)

    let isGuideCompleted = UserDefaults.standard.bool(forKey: "isGuideCompleted")

    let rootVC: UIViewController

    if isGuideCompleted {
      rootVC = MainViewController()
    } else {
      rootVC = WelcomeGuideViewController()
    }

    window.rootViewController = rootVC
    self.window = window
    window.makeKeyAndVisible()
  }
}
