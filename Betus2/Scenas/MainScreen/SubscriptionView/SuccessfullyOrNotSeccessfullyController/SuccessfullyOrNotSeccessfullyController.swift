
import UIKit
import SnapKit

class SuccessfullyOrNotSuccessfullyController: UIViewController {

    private let isSuccess: Bool

    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var firstBubleBackground: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "appleLogoFrame")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var secondBubleBackground: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "appleLogoFrame")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var successOrWrongView: SuccessOrWrongView = {
        let view = SuccessOrWrongView()
        view.backgroundColor = .topBottomViewColorGray
        view.makeRoundCorners(24)

        if isSuccess {
            view.showSuccessUI()
            view.onOkeyButton = { [weak self] in
                self?.moveToMainDashboard()
            }
        } else {
            view.showFailureUI()
            view.onOkeyButton = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }

        view.pressSupportButton = { [weak self] in
            self?.pressSupportButton()
        }
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setup()
        setupConstraints()
    }

    private func setup() {
        view.addSubview(firstBubleBackground)
        view.addSubview(secondBubleBackground)
        view.addSubview(successOrWrongView)
    }

    private func setupConstraints() {
        firstBubleBackground.snp.remakeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-116 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(432 * Constraint.yCoeff)
        }

        secondBubleBackground.snp.remakeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-14 * Constraint.yCoeff)
            make.leading.equalTo(view.snp.leading).offset(10 * Constraint.xCoeff)
            make.trailing.equalTo(view.snp.trailing).offset(6 * Constraint.xCoeff)
            make.height.equalTo(432 * Constraint.yCoeff)
        }

        successOrWrongView.snp.remakeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-24 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(295 * Constraint.yCoeff)
        }
    }

    private func moveToMainDashboard() {
        if isSuccess {
            let isUserSignedIn = UserDefaults.standard.string(forKey: "userId")?.isEmpty == false

            if isUserSignedIn {
                // ✅ User is subscribed and signed in → go to MainDashboardScene
                for controller in navigationController?.viewControllers ?? [] {
                    if let dashboard = controller as? MainDashboardScene {
                        navigationController?.popToViewController(dashboard, animated: true)
                        return
                    }
                }
                let mainDashboardVC = MainDashboardScene()
                navigationController?.setViewControllers([mainDashboardVC], animated: true)
            } else {
                // 🔹 User is subscribed but not signed in → go to SignInController
                let signInViewController = SignInController()
                navigationController?.setViewControllers([signInViewController], animated: true)
            }
        } else {
            // ❌ If purchase failed, return to the previous page
            navigationController?.popViewController(animated: true)
        }
    }



    private func pressSupportButton() {
        let termsURL = "https://beat-sports.pro/support"
        let webViewController = WebViewController(urlString: termsURL)
        navigationController?.present(webViewController, animated: true)
    }
}
