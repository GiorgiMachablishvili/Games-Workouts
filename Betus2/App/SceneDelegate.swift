

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var storeVM = StoreVM()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
////        let mainViewController = SubscriptionMainViewController()
////        window?.rootViewController = UINavigationController(rootViewController: mainViewController)
//        decideInitialViewController()
////        ifUserISCreatedOrNot()
//        window?.makeKeyAndVisible()
        Task {
            await storeVM.updateCustomerProductStatus()
            DispatchQueue.main.async {
                self.decideInitialViewController()
                self.window?.makeKeyAndVisible()
            }
        }
    }

//        func ifUserISCreatedOrNot() {
//            if let userId = UserDefaults.standard.string(forKey: "userId"), !userId.isEmpty {
//                print(userId)
//                let mainViewController = MainDashboardScene()
//                UserDefaults.standard.setValue(false, forKey: "isGuestUser")
//                window?.rootViewController = UINavigationController(rootViewController: mainViewController)
//            } else {
//                let signInViewController = SignInController()
//                window?.rootViewController = UINavigationController(rootViewController: signInViewController)
//            }
//        }

    private func decideInitialViewController() {
            let isUserSignedIn = UserDefaults.standard.string(forKey: "userId")?.isEmpty == false
            let isSubscribed = !(storeVM.purchasedSubscriptions.isEmpty) // Check if any subscription exists

            if isSubscribed {
                if isUserSignedIn {
                    // ✅ User is subscribed and signed in → go to MainDashboardScene
                    let mainViewController = MainDashboardScene()
                    window?.rootViewController = UINavigationController(rootViewController: mainViewController)
                } else {
                    // 🔹 User is subscribed but not signed in → go to SignInController
                    let signInViewController = SignInController()
                    window?.rootViewController = UINavigationController(rootViewController: signInViewController)
                }
            } else {
                // ❌ User is NOT subscribed → go to SubscriptionMainViewController
                let subscriptionViewController = SubscriptionMainViewController()
                window?.rootViewController = UINavigationController(rootViewController: subscriptionViewController)
            }
        }

    func sceneDidDisconnect(_ scene: UIScene) {
        Task {
            await storeVM.updateCustomerProductStatus()
            DispatchQueue.main.async {
                self.decideInitialViewController()
            }
        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        Task {
            await storeVM.updateCustomerProductStatus()
            DispatchQueue.main.async {
                self.decideInitialViewController()
            }
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

