

import UIKit
import SnapKit
import AuthenticationServices
import Alamofire
import ProgressHUD
import StoreKit

class ProfileViewController: UIViewController {

    private var workoutHistory: [WorkoutScore] = []

    private lazy var staticView: TrainingStaticView = {
        let view = TrainingStaticView()
        view.makeRoundCorners(32)
        view.backgroundColor = .topBottomViewColorGray
        view.onBackButtonTap = { [weak self] in
            self?.navigationMainDashboard()
        }
        return view
    }()

    private lazy var helperView: HelperProfileView = {
        let view = HelperProfileView()
        view.makeRoundCorners(32)
        view.backgroundColor = .topBottomViewColorGray
        view.rateButton = { [weak self] in
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
        view.privacyPolicy = { [weak self] in
            self?.privacyPolicyButton()
        }
        return view
    }()

    private lazy var warningViewRed: WarningViews = {
        let view = WarningViews()
        view.makeRoundCorners(16)
        view.backgroundColor = .redColor.withAlphaComponent(0.2)
        return view
    }()

    private lazy var deleteButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Delete Account", for: .normal)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.titleLabel?.font = UIFont.goldmanRegular(size: 14)
        view.makeRoundCorners(23)
        view.backgroundColor = .topBottomViewColorGray
        view.addTarget(self, action: #selector(pressDeleteButton), for: .touchUpInside)
        return view
    }()

    private lazy var signInButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Sing In", for: .normal)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.titleLabel?.font = UIFont.goldmanRegular(size: 14)
        view.makeRoundCorners(23)
        view.backgroundColor = .redColor
        view.isHidden = true
        view.addTarget(self, action: #selector(pressSignInButton), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()

        if UserDefaults.standard.bool(forKey: "isGuestUser") {
            setupForGuestUser()
        } else {
            fetchWorkoutScore()
        }

        //        hiddenOrUnhidden()
    }

    private func setup() {
        view.addSubview(staticView)
        view.addSubview(helperView)
        view.addSubview(warningViewRed)
        view.addSubview(deleteButton)
        view.addSubview(signInButton)
    }

    private func setupConstraints() {
        staticView.snp.remakeConstraints { make in
            make.top.equalTo(view.snp.top).offset(48 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(247 * Constraint.yCoeff)
        }

        helperView.snp.remakeConstraints { make in
            make.top.equalTo(staticView.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(220 * Constraint.yCoeff)
        }

        warningViewRed.snp.remakeConstraints { make in
            make.top.equalTo(helperView.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(81 * Constraint.yCoeff)
        }

        deleteButton.snp.remakeConstraints { make in
            make.top.equalTo(warningViewRed.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
        }

        signInButton.snp.remakeConstraints { make in
            make.top.equalTo(helperView.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(32 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
        }
    }

    private func setupForGuestUser() {
        if let soccerLabel = staticView.soccerView.viewWithTag(1001) as? UILabel,
           let basketballLabel = staticView.basketballView.viewWithTag(1001) as? UILabel,
           let volleyballLabel = staticView.volleyballView.viewWithTag(1001) as? UILabel,
           let tennisLabel = staticView.tennisView.viewWithTag(1001) as? UILabel {
            soccerLabel.text = "?"
            basketballLabel.text = "?"
            volleyballLabel.text = "?"
            tennisLabel.text = "?"
        }
        warningViewRed.isHidden = true
        deleteButton.isHidden = true
        signInButton.isHidden = false
    }

    func hiddenOrUnhidden() {
        let isGuestUser = UserDefaults.standard.bool(forKey: "isGuestUser")
        warningViewRed.isHidden = isGuestUser
        deleteButton.isHidden = isGuestUser
        signInButton.isHidden = !isGuestUser
    }

    private func navigationMainDashboard() {
        navigationController?.popViewController(animated: true)
    }
    
    func privacyPolicyButton() {
        let termsURL = "https://beat-sports.pro/privacy"
        let webViewController = WebViewController(urlString: termsURL)
        navigationController?.present(webViewController, animated: true)    }
    
    func termsButton() {
        let termsURL = "https://beat-sports.pro/terms"
        let webViewController = WebViewController(urlString: termsURL)
        navigationController?.present(webViewController, animated: true)    }
    
    func supportButton() {
        let termsURL = "https://beat-sports.pro/support"
        let webViewController = WebViewController(urlString: termsURL)
        navigationController?.present(webViewController, animated: true)    }

    @objc func pressDeleteButton() {
        let alertController = UIAlertController(
            title: "Delete Account",
            message: "Are you sure you want to delete your account? This action cannot be undone.",
            preferredStyle: .alert
        )

        // Define the delete action
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            guard let userId = UserDefaults.standard.value(forKey: "userId") as? String else {
                return
            }

            let url = String.userDelete(userId: userId)

            NetworkManager.shared.delete(url: url, parameters: nil, headers: nil) { (result: Result<EmptyResponse>) in
                switch result {
                case .success:
                    print("Account deleted successfully")
                    UserDefaults.standard.removeObject(forKey: "userId")
                    DispatchQueue.main.async {
                        let successAlert = UIAlertController(
                            title: "Account Deleted",
                            message: "Your account has been deleted successfully.",
                            preferredStyle: .alert
                        )
                        successAlert.addAction(UIAlertAction(title: "Delete", style: .default) { _ in
                            self.removeSignInControllerAndNavigate()
                        })
                        self.present(successAlert, animated: true)
                    }
                case .failure(let error):
                    print("Failed to delete account: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        let errorAlert = UIAlertController(
                            title: "Error",
                            message: "Failed to delete account. Please try again later.",
                            preferredStyle: .alert
                        )
                        errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(errorAlert, animated: true)
                    }
                }
            }
        }

        // Define the cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        // Add actions to the alert controller
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        // Present the alert controller
        self.present(alertController, animated: true)
    }

    private func removeSignInControllerAndNavigate() {
        if let navigationController = navigationController {
            var viewControllers = navigationController.viewControllers
            // Remove SignInController if it's in the stack
            viewControllers.removeAll { $0 is SignInController }
            navigationController.setViewControllers(viewControllers, animated: false)

            // Navigate to the initial screen or dashboard
            navigationController.popToRootViewController(animated: true)
        }
    }

    @objc func pressSignInButton() {
        // Simulating tokens for testing
//        let mockPushToken = "mockPushToken"
//        let mockAppleToken = "mockAppleToken"
//
//        // Store mock tokens in UserDefaults
//        UserDefaults.standard.setValue(mockPushToken, forKey: "PushToken")
//        UserDefaults.standard.setValue(mockAppleToken, forKey: "AccountCredential")
//
//        // Call createUser to simulate user creation
//        createUser()

        let authorizationProvider = ASAuthorizationAppleIDProvider()
        let request = authorizationProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
        let mainView = MainDashboardScene()
        navigationController?.pushViewController(mainView, animated: true)
    }

    private func createUser() {
        NetworkManager.shared.showProgressHud(true, animated: true)

        let pushToken = UserDefaults.standard.string(forKey: "PushToken") ?? ""
        let appleToken = UserDefaults.standard.string(forKey: "AccountCredential") ?? ""

        // Prepare parameters
        let parameters: [String: Any] = [
            "push_token": pushToken,
            "auth_token": appleToken
        ]

        // Make the network request
        NetworkManager.shared.post(
            url: String.userCreate(),
            parameters: parameters,
            headers: nil
        ) { [weak self] (result: Result<UserCreateInfo>) in
            guard let self = self else { return }

            DispatchQueue.main.async {
                NetworkManager.shared.showProgressHud(false, animated: false)
                UserDefaults.standard.setValue(false, forKey: "isGuestUser")
            }

            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    print("User created: \(userInfo)")
                    UserDefaults.standard.setValue(userInfo.id, forKey: "userId")
                    print("Received User ID: \(userInfo.id)")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", description: error.localizedDescription)
                }
                print("Error: \(error)")
            }
        }
        let mainVC = MainDashboardScene()
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(mainVC, animated: true)
    }

    private func showAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ProfileViewController: ASAuthorizationControllerDelegate /*ASAuthorizationControllerPresentationContextProviding*/ {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }

        UserDefaults.standard.setValue(credential.user, forKey: "AccountCredential")
                createUser()
    }

        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            print("Authorization failed: \(error.localizedDescription)")
//            showAlert(title: "Sign In Failed", description: error.localizedDescription)
        }
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        let nsError = error as NSError
//        if nsError.domain == ASAuthorizationError.errorDomain {
//            switch nsError.code {
//            case ASAuthorizationError.canceled.rawValue:
//                print("User canceled the Apple Sign-In process.")
//                // Optionally show a message or simply return
//                return
//            case ASAuthorizationError.failed.rawValue:
//                print("Sign-In failed.")
//                showAlert(title: "Sign In Failed", description: "Something went wrong. Please try again.")
//            case ASAuthorizationError.invalidResponse.rawValue:
//                print("Invalid response from Apple Sign-In.")
//                showAlert(title: "Invalid Response", description: "We couldn't authenticate you. Please try again.")
//            case ASAuthorizationError.notHandled.rawValue:
//                print("Apple Sign-In not handled.")
//                showAlert(title: "Not Handled", description: "The request wasn't handled. Please try again.")
//            case ASAuthorizationError.unknown.rawValue:
//                print("An unknown error occurred.")
//                showAlert(title: "Unknown Error", description: "An unknown error occurred. Please try again.")
//            default:
//                break
//            }
//        } else {
//            print("Authorization failed with error: \(error.localizedDescription)")
//            showAlert(title: "Sign In Failed", description: error.localizedDescription)
//        }
//    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


//MARK fetch get workouts count
extension ProfileViewController {
    private func fetchWorkoutScore() {
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? String else {
            return
        }

        let url = String.getWorkoutCountsAndDate(userId: userId)
        NetworkManager.shared.get(url: url, parameters: nil, headers: nil) { (result: Result<[WorkoutScore]>) in
            switch result {
            case .success(let scores):
                self.workoutHistory = scores
                DispatchQueue.main.async {
                    self.updateTrainingStaticView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func updateTrainingStaticView() {
        //        guard let score = score else { return }
        //        staticView.updateWorkoutPoints(
        //            soccer: score.soccerWorkoutCount,
        //            volleyball: score.volleyballWorkoutCount,
        //            basketball: score.basketballWorkoutCount,
        //            tennis: score.tennisWorkoutCount
        //        )
        let totalSoccerCount = workoutHistory.reduce(0) { $0 + $1.soccerWorkoutCount }
        let totalVolleyballCount = workoutHistory.reduce(0) { $0 + $1.volleyballWorkoutCount }
        let totalBasketballCount = workoutHistory.reduce(0) { $0 + $1.basketballWorkoutCount }
        let totalTennisCount = workoutHistory.reduce(0) { $0 + $1.tennisWorkoutCount }

        // Update the static view with aggregated totals
        staticView.updateWorkoutPoints(
            soccer: totalSoccerCount,
            volleyball: totalVolleyballCount,
            basketball: totalBasketballCount,
            tennis: totalTennisCount
        )
    }
}
