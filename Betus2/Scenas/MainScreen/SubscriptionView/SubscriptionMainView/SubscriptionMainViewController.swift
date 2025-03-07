

import UIKit
import SnapKit
import Combine
import StoreKit

@available(iOS 15.0, *)
class SubscriptionMainViewController: UIViewController {

    private var storeVM = StoreVM()
    private var cancellables = Set<AnyCancellable>()

    private var selectedSubscriptionType: SubscriptionType? = nil

    enum Product: String, CaseIterable {
        case monthly = "bsu_1499_1year"
        case yearly = "bsu_199_1month"
    }

    private lazy var tennisBackground: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "appleLogoFrame")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var tennisBlurImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "tennisBlurImage")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var volleyballBackground: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "appleLogoFrame")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var volleyballBlurImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "volleyballBlurImage")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var basketballBackground: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "appleLogoFrame")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var basketballBlurImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "basketballBlurImage")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var subscriptionView: SubscriptionView = {
        let view = SubscriptionView()
        view.backgroundColor = .topBottomViewColorGray
        view.makeRoundCorners(24)
        view.onGoProButtonTap = { [weak self] in
            self?.startSubscription()
        }
        view.onGoBackMainView = { [weak self] in
            self?.moveToSignInOrMainView()
        }
        view.didPressTermsOfUser = { [weak self] in
            self?.pressTermsOfUse()
        }
        view.switcherIsOn = { [weak self] in
            self?.yearlyOrMonthly()
        }
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBlack
        setup()
        setupConstraints()
        addGestureRecognizers()
        observeSubscriptionChanges()

        Task {
            print("🔄 Fetching products before user can subscribe...")
            await storeVM.requestProducts()
        }
    }

    private func setup() {
        view.addSubview(tennisBackground)
        tennisBackground.addSubview(tennisBlurImage)
        view.addSubview(volleyballBackground)
        volleyballBackground.addSubview(volleyballBlurImage)
        view.addSubview(basketballBackground)
        basketballBackground.addSubview(basketballBlurImage)
        view.addSubview(subscriptionView)
    }

    private func setupConstraints() {
        tennisBackground.snp.remakeConstraints { make in
            make.top.equalTo(view.snp.top).offset(-69 * Constraint.yCoeff)
            make.leading.equalTo(view.snp.leading).offset(211 * Constraint.xCoeff)
            make.height.width.equalTo(260 * Constraint.yCoeff)
        }

        tennisBlurImage.snp.remakeConstraints { make in
            make.center.equalTo(tennisBackground.snp.center)
            make.height.width.equalTo(140 * Constraint.yCoeff)
        }

        volleyballBackground.snp.remakeConstraints { make in
            make.top.equalTo(view.snp.top).offset(149 * Constraint.yCoeff)
            make.leading.equalTo(view.snp.leading).offset(-103 * Constraint.xCoeff)
            make.height.width.equalTo(260 * Constraint.yCoeff)
        }

        volleyballBlurImage.snp.remakeConstraints { make in
            make.center.equalTo(volleyballBackground.snp.center)
            make.height.width.equalTo(140 * Constraint.yCoeff)
        }

        basketballBackground.snp.remakeConstraints { make in
            make.top.equalTo(view.snp.top).offset(284 * Constraint.yCoeff)
            make.trailing.equalTo(view.snp.trailing).offset(86 * Constraint.xCoeff)
            make.height.width.equalTo(260 * Constraint.yCoeff)
        }

        basketballBlurImage.snp.remakeConstraints { make in
            make.center.equalTo(basketballBackground.snp.center)
            make.height.width.equalTo(140 * Constraint.yCoeff)
        }

        subscriptionView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.bottom.equalTo(view.snp.bottom).offset(-24 * Constraint.yCoeff)
            make.height.equalTo(612 * Constraint.yCoeff)
        }
    }

    private func addGestureRecognizers() {
        let yearlyTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapYearlySubscription))
        subscriptionView.yearlySubscription.addGestureRecognizer(yearlyTapGesture)
        subscriptionView.yearlySubscription.isUserInteractionEnabled = true

        let monthlyTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMonthlySubscription))
        subscriptionView.monthlySubscription.addGestureRecognizer(monthlyTapGesture)
        subscriptionView.monthlySubscription.isUserInteractionEnabled = true
    }

    private func observeSubscriptionChanges() {
        storeVM.$purchasedSubscriptions
            .receive(on: DispatchQueue.main)
            .sink { [weak self] subscriptions in
                guard let self = self else { return }

                if self.navigationController?.topViewController is SubscriptionMainViewController {
                    return
                }
                if subscriptions.isEmpty {
                    self.updateMainDashboardForFreeUser()
                } else {
                    self.updateMainDashboardForSubscribedUser()
                }
            }
            .store(in: &cancellables)
    }

    private func updateMainDashboardForFreeUser() {
        // Perform changes for free user (e.g., update background or restrict features)
        let mainDashboardVC = MainDashboardScene()
        mainDashboardVC.view.backgroundColor = .lightGray // Example: change to a "free" background
        navigationController?.setViewControllers([mainDashboardVC], animated: true)
    }

    private func updateMainDashboardForSubscribedUser() {
        // Perform changes for subscribed user
        let mainDashboardVC = MainDashboardScene()
        mainDashboardVC.view.backgroundColor = .green // Example: change to a "premium" background
        navigationController?.setViewControllers([mainDashboardVC], animated: true)
    }

    private func yearlyOrMonthly() {
        guard let subscriptionType = selectedSubscriptionType else {
            print("❌ No subscription plan selected. Please choose one.")
            return
        }

        switch subscriptionType {
        case .yearly:
            print("🔄 Reloading: Auto-subscription is ON for Yearly Plan")
            didTapYearlySubscription()
        case .monthly:
            print("🔄 Reloading: Auto-subscription is ON for Monthly Plan")
            didTapMonthlySubscription()
        }
    }

    @objc private func didTapYearlySubscription() {
        selectedSubscriptionType = .yearly

        updateSubscriptionSelection(
            selectedView: subscriptionView.yearlySubscription,
            deselectedView: subscriptionView.monthlySubscription
        )
        if SKPaymentQueue.canMakePayments() {
            let set : Set<String> = [Product.yearly.rawValue]
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
        }
    }

    @objc private func didTapMonthlySubscription() {
        selectedSubscriptionType = .monthly

        updateSubscriptionSelection(
            selectedView: subscriptionView.monthlySubscription,
            deselectedView: subscriptionView.yearlySubscription
        )
        if SKPaymentQueue.canMakePayments() {
            let set : Set<String> = [Product.monthly.rawValue]
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
        }
    }

    private func updateSubscriptionSelection(selectedView: UIView, deselectedView: UIView) {
           if let yearlyView = selectedView as? YearlySubscriptionView {
               yearlyView.backgroundColor = .grayCalendarDayName
               yearlyView.fillCircleImage.isHidden = false
           } else if let monthlyView = selectedView as? MonthlySubscriptionView {
               monthlyView.backgroundColor = .grayCalendarDayName
               monthlyView.fillCircleImage.isHidden = false
           }

           if let yearlyView = deselectedView as? YearlySubscriptionView {
               yearlyView.backgroundColor = .topBottomViewColorGray
               yearlyView.fillCircleImage.isHidden = true
           } else if let monthlyView = deselectedView as? MonthlySubscriptionView {
               monthlyView.backgroundColor = .topBottomViewColorGray
               monthlyView.fillCircleImage.isHidden = true
           }
       }

    private func startSubscription() {
        guard let subscriptionType = selectedSubscriptionType else {
            print("❌ No subscription selected!")
            return
        }

        let productID = subscriptionType == .yearly ? "bsu_1499_1year" : "bsu_199_1month"
        print("🚀 Starting Subscription for \(productID)")

//        Task {
//            if let product = storeVM.subscriptions.first(where: { $0.id == productID }) {
//                do {
//                    let transaction = try await storeVM.purchase(product)
//                    let success = transaction != nil
//                    print(success ? "🎉 Subscription Successful!" : "❌ Subscription Failed")
//
//                    moveSuccsOrNotView(isSuccess: success)
//                } catch {
//                    print("❌ Subscription Error: \(error)")
//                    moveSuccsOrNotView(isSuccess: false)
//                }
//            }
//        }

        Task {
            print("✅ Inside Task block") // Debugging
            let productID = selectedSubscriptionType == .yearly ? "bsu_1499_1year" : "bsu_199_1month"

            if let product = storeVM.subscriptions.first(where: { $0.id == productID }) {
                do {
                    print("💳 Purchasing product: \(product.id)")
                    let transaction = try await storeVM.purchase(product)
                    let success = transaction != nil
                    print(success ? "🎉 Subscription Successful!" : "❌ Subscription Failed")

                    moveSuccsOrNotView(isSuccess: success)
                } catch {
                    print("❌ Subscription Error: \(error)")
                    moveSuccsOrNotView(isSuccess: false)
                }
            } else {
                print("❌ ERROR: Product with ID \(productID) not found in storeVM.subscriptions!")
            }
        }

    }

    private func moveSuccsOrNotView(isSuccess: Bool) {
        let succOrNotVC = SuccessfullyOrNotSuccessfullyController(isSuccess: isSuccess)
        navigationController?.pushViewController(succOrNotVC, animated: true)
    }

    private func moveToSignInOrMainView() {
        if let userId = UserDefaults.standard.string(forKey: "userId"), !userId.isEmpty {
            let mainDashboardVC = MainDashboardScene()
            navigationController?.pushViewController(mainDashboardVC, animated: true)
        } else {
            let signInVC = SignInController()
            navigationController?.pushViewController(signInVC, animated: true)
        }
    }

    private func pressTermsOfUse() {
        let termsURL = "https://beat-sports.pro/terms"
        let webViewController = WebViewController(urlString: termsURL)
        navigationController?.present(webViewController, animated: true)
    }
}


extension SubscriptionMainViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let oProduct = response.products.first {
            print("Product is available!")
            self.purchase(aproduct: oProduct)
        } else {
            print("Product is not available!")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("CCustomer is in process of purchase")
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("purchased")
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("failed")
            case .restored:
                print("restore")
            case .deferred:
                print("deferred")
            default: break
            }
        }
    }
    
    func purchase(aproduct: SKProduct) {
        let payment = SKPayment(product: aproduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }

}
