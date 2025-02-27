

import UIKit
import SnapKit
import Combine

@available(iOS 15.0, *)
class SubscriptionMainViewController: UIViewController {

    private var storeVM = StoreVM()
    private var cancellables = Set<AnyCancellable>()

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
            self?.moveSuccsOrNotView()
        }
        view.onGoBackMainView = { [weak self] in
            self?.moveToBackView()
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
            make.height.equalTo(518 * Constraint.yCoeff)
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

    @objc private func didTapYearlySubscription() {
        updateSubscriptionSelection(
            selectedView: subscriptionView.yearlySubscription,
            deselectedView: subscriptionView.monthlySubscription
        )
        Task {
            if let yearlyProduct = storeVM.subscriptions.first(where: { $0.id == "subscription.yearly" }) {
                do {
                    let transaction = try await storeVM.purchase(yearlyProduct)

                    // Handle successful transaction
                    if transaction != nil {

                    }
                } catch {
                    print("Failed to purchase yearly subscription: \(error)")
                }
            }
        }
    }

    @objc private func didTapMonthlySubscription() {
        updateSubscriptionSelection(
            selectedView: subscriptionView.monthlySubscription,
            deselectedView: subscriptionView.yearlySubscription
        )
        Task {
            if let monthlyProduct = storeVM.subscriptions.first(where: { $0.id == "subscription.monthly" }) {
                do {
                    let transaction = try await storeVM.purchase(monthlyProduct)

                    // Handle successful transaction
                    if transaction != nil {
                    }
                } catch {
                    print("Failed to purchase monthly subscription: \(error)")
                }
            }
        }
    }


//    @objc private func didTapYearlySubscription() {
//        Task {
//            if let yearlyProduct = storeVM.subscriptions.first(where: { $0.id == "subscription.yearly" }) {
//
//                do {
//                    try await storeVM.purchase(yearlyProduct)
//                    updateSubscriptionSelection(
//                        selectedView: subscriptionView.yearlySubscription,
//                        deselectedView: subscriptionView.monthlySubscription
//                    )
//                } catch {
//                    print("Failed to purchase yearly subscription: \(error)")
//                }
//            }
//        }
//    }
//
//
//    @objc private func didTapMonthlySubscription() {
//        Task {
//            if let monthlyProduct = storeVM.subscriptions.first(where: { $0.id == "subscription.monthly" }) {
//                do {
//                    try await storeVM.purchase(monthlyProduct)
//                    updateSubscriptionSelection(
//                        selectedView: subscriptionView.monthlySubscription,
//                        deselectedView: subscriptionView.yearlySubscription
//                    )
//                } catch {
//                    print("Failed to purchase monthly subscription: \(error)")
//                }
//            }
//        }
//    }

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

    private func moveSuccsOrNotView() {
        let succOrNotVC = SuccessfullyOrNotSuccessfullyController()
        navigationController?.pushViewController(succOrNotVC, animated: true)
    }

    private func moveToBackView() {
        navigationController?.popViewController(animated: true)
    }
}
