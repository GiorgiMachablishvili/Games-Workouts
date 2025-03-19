

import UIKit
import SnapKit
import AuthenticationServices
import Alamofire
import ProgressHUD
import StoreKit

class ProfileViewController: UIViewController {

    private var workoutHistory: [WorkoutScore] = []


    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = UIColor.mainBlack
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        setupHierarchy()
        configureCompositionLayout()


        if UserDefaults.standard.bool(forKey: "isGuestUser") {
//            setupForGuestUser()
            collectionView.reloadData()
        } else {
            fetchWorkoutScore()
        }

        // Ensuring hiddenOrUnhidden is executed after UI reload
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.hiddenOrUnhidden()
        }
    }

    private func setup() {
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }


    func setupHierarchy() {
        collectionView.register(TrainingStaticView.self, forCellWithReuseIdentifier: String(describing: TrainingStaticView.self))
        collectionView.register(HelperProfileView.self, forCellWithReuseIdentifier: String(describing: HelperProfileView.self))
        collectionView.register(WarningAndButtonsCell.self, forCellWithReuseIdentifier: String(describing: WarningAndButtonsCell.self))
    }

    func configureCompositionLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self?.trainingStaticView()
            case 1:
                return self?.helperStaticView()
            case 2:
                return self?.warningAndButtonView()
            default:
                return self?.defaultLayout()
            }
        }
        self.collectionView.setCollectionViewLayout(layout, animated: false)
    }

    func trainingStaticView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(920 * Constraint.yCoeff))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(920 * Constraint.yCoeff)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(
            top: 20 * Constraint.yCoeff,
            leading: 5 * Constraint.xCoeff,
            bottom: 0 * Constraint.yCoeff,
            trailing: 5 * Constraint.xCoeff
        )
        return section
    }

    func helperStaticView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(215 * Constraint.yCoeff))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(215 * Constraint.yCoeff)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(
            top: 10 * Constraint.yCoeff,
            leading: 0 * Constraint.xCoeff,
            bottom: 0 * Constraint.yCoeff,
            trailing: 0 * Constraint.xCoeff
        )
        return section
    }

    func warningAndButtonView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(150 * Constraint.yCoeff))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(150 * Constraint.yCoeff)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(
            top: 20 * Constraint.yCoeff,
            leading: 0 * Constraint.xCoeff,
            bottom: 50 * Constraint.yCoeff,
            trailing: 0 * Constraint.xCoeff
        )
        return section
    }

    func defaultLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.7),
            heightDimension: .absolute(200 * Constraint.yCoeff)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }

    func hiddenOrUnhidden() {
        let isGuestUser = UserDefaults.standard.bool(forKey: "isGuestUser")

        DispatchQueue.main.async {
            guard let cell = self.collectionView.cellForItem(at: IndexPath(item: 0, section: 2)) as? WarningAndButtonsCell else {
                print("⚠️ WarningAndButtonsCell not found in the current view")
                return
            }
            cell.deleteButton.isHidden = isGuestUser
            cell.signInButton.isHidden = !isGuestUser
            print("✅ Updated button visibility - Delete: \(cell.deleteButton.isHidden), SignIn: \(cell.signInButton.isHidden)")
        }
    }

    private func navigationMainDashboard() {
        navigationController?.popViewController(animated: true)
    }

    private func updateMainDashboardForSubscribedUser() {
        let mainDashboardVC = MainDashboardScene()
        mainDashboardVC.view.backgroundColor = .green
        navigationController?.setViewControllers([mainDashboardVC], animated: true)
    }

//    func restoreUserInfo() {
//        print("🔄 Attempting to restore purchases...")
//        SKPaymentQueue.default().add(self)
//        SKPaymentQueue.default().restoreCompletedTransactions()
//    }

    func privacyPolicyButton() {
        let termsURL = "https://beat-sports.pro/privacy"
        let webViewController = WebViewController(urlString: termsURL)
        navigationController?.present(webViewController, animated: true)  
    }

    func termsButton() {
        let termsURL = "https://beat-sports.pro/terms"
        let webViewController = WebViewController(urlString: termsURL)
        navigationController?.present(webViewController, animated: true)
    }

    func supportButton() {
        let termsURL = "https://beat-sports.pro/support"
        let webViewController = WebViewController(urlString: termsURL)
        navigationController?.present(webViewController, animated: true)
    }

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
//                    self.updateTrainingStaticView()
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func calculateTotalWorkoutPoints() -> [String: Int] {
        var totalPoints: [String: Int] = [
            "soccer": 0, "volleyball": 0, "basketball": 0, "tennis": 0,
            "americanFootball": 0, "badminton": 0, "baseball": 0, "rugby": 0,
            "boxing": 0, "cycling": 0, "golf": 0, "gymnastics": 0, "iceHockey": 0,
            "lacrosse": 0, "mma": 0, "wrestling": 0, "rowing": 0, "running": 0,
            "swimming": 0, "tableTennis": 0
        ]

        for history in workoutHistory {
            totalPoints["soccer"]! += history.soccerWorkoutCount
            totalPoints["volleyball"]! += history.volleyballWorkoutCount
            totalPoints["basketball"]! += history.basketballWorkoutCount
            totalPoints["tennis"]! += history.tennisWorkoutCount
            totalPoints["americanFootball"]! += history.americanFootballWorkoutCount
            totalPoints["badminton"]! += history.badmintonWorkoutCount
            totalPoints["baseball"]! += history.baseballWorkoutCount
            totalPoints["rugby"]! += history.rugbyWorkoutCount
            totalPoints["boxing"]! += history.boxingWorkoutCount
            totalPoints["cycling"]! += history.cyclingWorkoutCount
            totalPoints["golf"]! += history.golfWorkoutCount
            totalPoints["gymnastics"]! += history.gymnasticsWorkoutCount
            totalPoints["iceHockey"]! += history.iceHockeyWorkoutCount
            totalPoints["lacrosse"]! += history.lacrosseWorkoutCount
            totalPoints["mma"]! += history.mmaWorkoutCount
            totalPoints["wrestling"]! += history.wrestlingWorkoutCount
            totalPoints["rowing"]! += history.rowingWorkoutCount
            totalPoints["running"]! += history.runningWorkoutCount
            totalPoints["swimming"]! += history.swimmingWorkoutCount
            totalPoints["tableTennis"]! += history.tableTennisWorkoutCount
        }
        return totalPoints
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: TrainingStaticView.self),
                for: indexPath) as? TrainingStaticView else {
                return UICollectionViewCell()
            }
            cell.updateWorkoutPoints(points: calculateTotalWorkoutPoints())
            cell.onBackButtonTap = { [weak self] in
            self?.navigationMainDashboard()
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: HelperProfileView.self),
                for: indexPath) as? HelperProfileView else {
                return UICollectionViewCell()
            }
            cell.rateButton = { [weak cell] in
                guard let windowScene = cell?.window?.windowScene else { return }
                SKStoreReviewController.requestReview(in: windowScene)
            }
            cell.privacyPolicy = { [weak self] in
                self?.privacyPolicyButton()
            }
            cell.terms = { [weak self] in
                self?.termsButton()
            }
            cell.support = { [weak self] in
                self?.supportButton()
            }
//            cell.restorePurchases = { [weak self] in
//                self?.restoreUserInfo()
//            }
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: WarningAndButtonsCell.self),
                for: indexPath) as? WarningAndButtonsCell else {
                return UICollectionViewCell()
            }
            let isGuestUser = UserDefaults.standard.bool(forKey: "isGuestUser")
            cell.deleteButton.isHidden = isGuestUser
            cell.signInButton.isHidden = !isGuestUser

            cell.didPressSignInButton = { [weak self] in
                self?.pressSignInButton()
            }
            cell.didPressDeleteButton = { [weak self] in
                self?.pressDeleteButton()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension ProfileViewController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .restored:
                print("✅ Purchase restored: \(transaction.payment.productIdentifier)")
                SKPaymentQueue.default().finishTransaction(transaction)
                DispatchQueue.main.async {
                    self.showAlert(title: "Success", description: "Your purchases have been restored.")
                }
                updateMainDashboardForSubscribedUser()
            case .failed:
                print("❌ Restore failed: \(transaction.error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", description: "Failed to restore purchases. Please try again.")
                }
            default:
                break
            }
        }
    }

    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if queue.transactions.isEmpty {
            print("❌ No purchases found to restore.")
            DispatchQueue.main.async {
                self.showAlert(title: "No Purchases", description: "No previous purchases were found for your account.")
            }
        }
    }
}
