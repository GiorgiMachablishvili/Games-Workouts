

import UIKit
import SnapKit
import AuthenticationServices
import Alamofire
import ProgressHUD

class SignInController: UIViewController {

    private lazy var quickSignLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Quick sign in with Apple"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.goldmanBold(size: 32)
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()

    private lazy var mainImageViewFram: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "appleLogoFrame")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var timerBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .redColor.withAlphaComponent(0.2)
        view.makeRoundCorners(80)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var mainImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "appleLogo")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var signInInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Sign in with Apple for secure and easy access. Save your workouts and get personalized recommendations!"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.goldmanRegular(size: 14)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()

    private lazy var signInWithAppleButton: UIButton = {
        let view = UIButton(frame: .zero)
            view.setTitle("Sign In with Apple", for: .normal)
        view.setTitleColor(UIColor.mainBlack, for: .normal)
        view.backgroundColor = UIColor.whiteColor
            view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor.whiteColor.cgColor
            view.layer.borderWidth = 1
            let image = UIImage(named: "apple")?.withRenderingMode(.alwaysOriginal)
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 20, height: 20)).image { _ in
                image?.draw(in: CGRect(origin: .zero, size: CGSize(width: 20, height: 20)))
            }
            view.setImage(resizedImage, for: .normal)
            view.imageView?.contentMode = .scaleAspectFit
            view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
            view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            view.contentHorizontalAlignment = .center
            view.addTarget(self, action: #selector(clickSignInWithAppleButton), for: .touchUpInside)
            return view
    }()


    private lazy var logInAsGuestButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Login as a guest", for: .normal)
        view.backgroundColor = UIColor(hexString: "#111111")
        view.layer.cornerRadius = 16
        view.addTarget(self, action: #selector(clickLogInAsGuestButton), for: .touchUpInside)
        return view
    }()

    private lazy var termsButton: UIButton = {
        let view = UIButton(frame: .zero)
        let attributedTitle = NSAttributedString(
            string: "Terms of",
            attributes: [
                .font: UIFont.goldmanRegular(size: 12),
                .foregroundColor: UIColor.whiteColor,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        view.setAttributedTitle(attributedTitle, for: .normal)
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(clickTermsButton), for: .touchUpInside)
        return view
    }()

    private lazy var termsLine: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = UIColor.whiteColor
        return view
    }()

    private lazy var andLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "use and"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.goldmanRegular(size: 12)
        view.textAlignment = .center
        return view
    }()

    private lazy var privacyPolicyButton: UIButton = {
        let view = UIButton(frame: .zero)
        let attributedTitle = NSAttributedString(
            string: "Privacy Policy",
            attributes: [
                .font: UIFont.goldmanRegular(size: 12),
                .foregroundColor: UIColor.whiteColor,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        view.setAttributedTitle(attributedTitle, for: .normal)
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(clickPrivacyPolicyButton), for: .touchUpInside)
        return view
    }()

    private lazy var privacyLine: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = UIColor.whiteColor
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBlack
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        setup()
        setupConstraints()
    }

    private func setup() {
        view.addSubview(quickSignLabel)
        view.addSubview(mainImageViewFram)
        mainImageViewFram.addSubview(timerBackground)
        timerBackground.addSubview(mainImageView)
        view.addSubview(signInInfoLabel)
        view.addSubview(logInAsGuestButton)
        view.addSubview(termsButton)
        view.addSubview(termsLine)
        view.addSubview(andLabel)
        view.addSubview(privacyPolicyButton)
        view.addSubview(privacyLine)
        view.addSubview(signInWithAppleButton)
        view.addSubview(logInAsGuestButton)
    }

    private func setupConstraints() {
        quickSignLabel.snp.remakeConstraints { make in
            make.top.equalTo(view.snp.top).offset(222 * Constraint.yCoeff)
            make.centerX.equalToSuperview()
            make.height.equalTo(86 * Constraint.yCoeff)
            make.width.equalTo(285 * Constraint.xCoeff)
        }

        mainImageViewFram.snp.remakeConstraints { make in
            make.top.equalTo(view.snp.top).offset(270 * Constraint.yCoeff)
            make.centerX.equalToSuperview()
            make.height.equalTo(260 * Constraint.yCoeff)
            make.width.equalTo(260 * Constraint.xCoeff)
        }

        timerBackground.snp.remakeConstraints { make in
            make.center.equalTo(mainImageViewFram.snp.center)
            make.height.width.equalTo(160 * Constraint.yCoeff)
        }

        mainImageView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(140 * Constraint.yCoeff)
            make.width.equalTo(140 * Constraint.xCoeff)
        }

        signInInfoLabel.snp.remakeConstraints { make in
            make.top.equalTo(mainImageViewFram.snp.bottom).offset(3 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(44 * Constraint.xCoeff)
            make.height.equalTo(51 * Constraint.yCoeff)
        }

        termsButton.snp.remakeConstraints { make in
            make.top.equalTo(signInInfoLabel.snp.bottom).offset(32 * Constraint.yCoeff)
            make.leading.equalTo(view.snp.leading).offset(95 * Constraint.xCoeff)
            make.height.equalTo(14 * Constraint.yCoeff)
        }

        andLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(termsButton.snp.centerY)
            make.leading.equalTo(termsButton.snp.trailing).offset(2 * Constraint.xCoeff)
            make.height.equalTo(14 * Constraint.yCoeff)
        }

        privacyPolicyButton.snp.remakeConstraints { make in
            make.centerY.equalTo(termsButton.snp.centerY)
            make.leading.equalTo(andLabel.snp.trailing).offset(2 * Constraint.xCoeff)
            make.height.equalTo(14 * Constraint.yCoeff)
        }

        signInWithAppleButton.snp.remakeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-100 * Constraint.yCoeff)
            make.centerX.equalToSuperview()
            make.height.equalTo(48 * Constraint.yCoeff)
            make.width.equalTo(326 * Constraint.xCoeff)
        }

        logInAsGuestButton.snp.remakeConstraints { make in
            make.top.equalTo(signInWithAppleButton.snp.bottom).offset(8 * Constraint.yCoeff)
            make.centerX.equalToSuperview()
            make.height.equalTo(48 * Constraint.yCoeff)
            make.width.equalTo(326 * Constraint.xCoeff)
        }

    }

    @objc private func clickTermsButton() {
        let termsURL = "https://beat-sports.pro/terms"
        let webViewController = WebViewController(urlString: termsURL)
        navigationController?.present(webViewController, animated: true)
    }
    
    @objc private func clickPrivacyPolicyButton() {
        let termsURL = "https://beat-sports.pro/privacy"
        let webViewController = WebViewController(urlString: termsURL)
        navigationController?.present(webViewController, animated: true)
    }

    @objc private func clickSignInWithAppleButton() {
        let mockPushToken = "mockPushToken"
//        let mockAppleToken = "mockAppleToken"
//
//        UserDefaults.standard.setValue(mockPushToken, forKey: "PushToken")
//        UserDefaults.standard.setValue(mockAppleToken, forKey: "AccountCredential")
//
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
        let isProOrNot = UserDefaults.standard.bool(forKey: "isSubscribed")

        // Prepare parameters
        let parameters: [String: Any] = [
            "push_token": pushToken,
            "auth_token": appleToken,
            "is_pro": isProOrNot
        ]

        print("it is betus parameters: \(parameters)")

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

    @objc private func clickLogInAsGuestButton() {
        UserDefaults.standard.setValue(true, forKey: "isGuestUser")
        let mainVC = MainDashboardScene()
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(mainVC, animated: true)
    }
}

extension SignInController: ASAuthorizationControllerDelegate /*ASAuthorizationControllerPresentationContextProviding*/ {
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



