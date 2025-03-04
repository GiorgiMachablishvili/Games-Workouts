
import UIKit
import SnapKit

class SubscriptionView: UIView {

    var onGoProButtonTap: (() -> Void)?
    var onGoBackMainView: (() -> Void)?

    private lazy var xButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "xButton"), for: .normal)
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(didPressCancelButton), for: .touchUpInside)
        return view
    }()

    private lazy var subscriptionTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Subscription to Pro Level"
        view.font = UIFont.goldmanBold(size: 36)
        view.numberOfLines = 2
        view.textColor = .whiteColor
        return view
    }()

    private lazy var subscriptionInfo: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Think you need more content to become a real pro, subscribe and enjoy: "
        view.font = UIFont.goldmanBold(size: 12)
        view.numberOfLines = 2
        view.textColor = .grayCalendarDayName
        return view
    }()

    private lazy var subscriptionBenefits: SubscriptionBenefitsView = {
        let view = SubscriptionBenefitsView()
        view.backgroundColor = .clear
        return view
    }()

    var yearlySubscription: YearlySubscriptionView = {
        let view = YearlySubscriptionView()
        view.backgroundColor = .topBottomViewColorGray
        view.makeRoundCorners(12)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grayCalendarPoints.cgColor
        return view
    }()

    var monthlySubscription: MonthlySubscriptionView = {
        let view = MonthlySubscriptionView()
        view.backgroundColor = .topBottomViewColorGray
        view.makeRoundCorners(12)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grayCalendarPoints.cgColor
        return view
    }()

    private lazy var goToProButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle(" Go to Pro", for: .normal)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.backgroundColor = UIColor.redColor
        view.makeRoundCorners(16)
        let image = UIImage(named: "crown")?.withRenderingMode(.alwaysOriginal)
        let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 19 * Constraint.xCoeff, height: 18 * Constraint.yCoeff)).image { _ in
            image?.draw(in: CGRect(origin: .zero, size: CGSize(width: 19 * Constraint.xCoeff, height: 18 * Constraint.yCoeff)))
        }
        view.setImage(resizedImage, for: .normal)
        view.imageView?.contentMode = .scaleAspectFit
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8 * Constraint.xCoeff)
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8 * Constraint.xCoeff, bottom: 0, right: 0)
        view.contentHorizontalAlignment = .center
        view.addTarget(self, action: #selector(didPressGoToProButton), for: .touchUpInside)
        return view
    }()

    private lazy var cancelButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Cancel", for: .normal)
        view.titleLabel?.font = UIFont.goldmanRegular(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(didPressCancelButton), for: .touchUpInside)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(xButton)
        addSubview(subscriptionTitle)
        addSubview(subscriptionInfo)
        addSubview(subscriptionBenefits)
        addSubview(yearlySubscription)
        addSubview(monthlySubscription)
        addSubview(goToProButton)
        addSubview(cancelButton)
    }

    private func setupConstraints() {
        xButton.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(10 * Constraint.yCoeff)
            make.trailing.equalTo(snp.trailing).offset(-10 * Constraint.yCoeff)
            make.height.width.equalTo(24 * Constraint.yCoeff)
        }

        subscriptionTitle.snp.remakeConstraints { make in
            make.top.equalTo(xButton.snp.bottom).offset(10 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(86 * Constraint.yCoeff)
        }

        subscriptionInfo.snp.remakeConstraints { make in
            make.top.equalTo(subscriptionTitle.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(28 * Constraint.yCoeff)
        }

        subscriptionBenefits.snp.remakeConstraints { make in
            make.top.equalTo(subscriptionInfo.snp.bottom).offset(32 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(64 * Constraint.yCoeff)
        }

        yearlySubscription.snp.remakeConstraints { make in
            make.top.equalTo(subscriptionBenefits.snp.bottom).offset(32 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
        }

        monthlySubscription.snp.remakeConstraints { make in
            make.top.equalTo(yearlySubscription.snp.bottom).offset(4 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
        }

        goToProButton.snp.remakeConstraints { make in
            make.bottom.equalTo(snp.bottom).offset(-72 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(48 * Constraint.yCoeff)
        }

        cancelButton.snp.remakeConstraints { make in
            make.top.equalTo(goToProButton.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(48 * Constraint.yCoeff)
        }
    }

    @objc private func didPressGoToProButton() {
        onGoProButtonTap?()
    }

    @objc private func didPressCancelButton() {
        onGoBackMainView?()
    }
}
