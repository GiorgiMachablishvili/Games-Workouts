
import UIKit
import SnapKit

class SubscriptionView: UIView {

    var onGoProButtonTap: (() -> Void)?
    var onGoBackMainView: (() -> Void)?
    var didPressTermsOfUser: (() -> Void)?
    var didTapYearlySubscription: (() -> Void)?
    var didTapMonthlySubscription: (() -> Void)?

    var switcherIsOn: (() -> Void)?

    private var selectedSubscriptionType: SubscriptionType? = nil

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

    lazy var yearlySubscription: YearlySubscriptionView = {
        let view = YearlySubscriptionView()
        view.backgroundColor = .topBottomViewColorGray
        view.makeRoundCorners(12)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grayCalendarPoints.cgColor
        
        return view
    }()

    lazy var monthlySubscription: MonthlySubscriptionView = {
        let view = MonthlySubscriptionView()
        view.backgroundColor = .topBottomViewColorGray
        view.makeRoundCorners(12)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grayCalendarPoints.cgColor
        return view
    }()

    private lazy var autoSubscriptionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Auto-subscription"
        view.font = UIFont.goldmanRegular(size: 12)
        view.textColor = .whiteColor
        view.textAlignment = .left
        return view
    }()

    private lazy var autoSubscriptionSwitch: UISwitch = {
        let view = UISwitch()
//        view.onTintColor = UIColor(hexString: "#282828")
//        view.thumbTintColor = .redColor
        view.onTintColor = UIColor.redColor
        view.isOn = true
        view.addTarget(self, action: #selector(didToggleSubscriptionSwitch), for: .valueChanged)
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

    private lazy var termsTextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.isScrollEnabled = false
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.delegate = self
        view.textContainerInset = .zero
        view.textContainer.lineFragmentPadding = 0
        view.linkTextAttributes = [
            .foregroundColor: UIColor.whiteColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

        let firstLine = "By clicking the “Go to Pro” button you agree to the \n"
        let secondLine = "terms of use"

        let fullText = firstLine + secondLine
        let termsOfUseText = "terms of use"

        let attributedString = NSMutableAttributedString(string: fullText, attributes: [
            .font: UIFont.goldmanRegular(size: 12),
            .foregroundColor: UIColor.whiteColor.withAlphaComponent(0.3)
        ])

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 4

        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, fullText.count))

        let termsOfUseRange = (fullText as NSString).range(of: termsOfUseText)

        attributedString.addAttribute(.link, value: "termsOfUse", range: termsOfUseRange)

        view.attributedText = attributedString
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
        addSubview(autoSubscriptionLabel)
        addSubview(autoSubscriptionSwitch)
        addSubview(goToProButton)
        addSubview(cancelButton)
        addSubview(termsTextView)
    }

    private func setupConstraints() {
        xButton.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(10 * Constraint.yCoeff)
            make.trailing.equalTo(snp.trailing).offset(-10 * Constraint.yCoeff)
            make.height.width.equalTo(24 * Constraint.yCoeff)
        }

        subscriptionTitle.snp.remakeConstraints { make in
            make.top.equalTo(xButton.snp.bottom).offset(5 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(86 * Constraint.yCoeff)
        }

        subscriptionInfo.snp.remakeConstraints { make in
            make.top.equalTo(subscriptionTitle.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
        }

        subscriptionBenefits.snp.remakeConstraints { make in
            make.top.equalTo(subscriptionInfo.snp.bottom).offset(28 * Constraint.yCoeff)
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

        autoSubscriptionLabel.snp.remakeConstraints { make in
            make.top.equalTo(monthlySubscription.snp.bottom).offset(32 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(16 * Constraint.xCoeff)
            make.height.equalTo(26 * Constraint.yCoeff)
        }

        autoSubscriptionSwitch.snp.remakeConstraints { make in
            make.centerY.equalTo(autoSubscriptionLabel)
            make.trailing.equalTo(snp.trailing).offset(-16 * Constraint.xCoeff)
        }

        goToProButton.snp.remakeConstraints { make in
            make.top.equalTo(autoSubscriptionLabel.snp.bottom).offset(32 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(48 * Constraint.yCoeff)
        }

        cancelButton.snp.remakeConstraints { make in
            make.top.equalTo(goToProButton.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(48 * Constraint.yCoeff)
        }

        termsTextView.snp.remakeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
        }
    }

    @objc private func didToggleSubscriptionSwitch(_ sender: UISwitch) {
        if sender.isOn {
            switcherIsOn?()
//            if let subscriptionType = selectedSubscriptionType {
//                switch subscriptionType {
//                case .yearly:
//                    print("Auto-subscription is ON for Yearly Plan")
//                    didTapYearlySubscription?()
//                case .monthly:
//                    print("Auto-subscription is ON for Monthly Plan")
//                    didTapMonthlySubscription?()
//                }
//            } else {
//                print("No subscription plan selected. Please choose one.")
//                sender.isOn = false
//            }
        } else {
            print("Auto-subscription is OFF")
        }
    }

    @objc private func didPressGoToProButton() {
        onGoProButtonTap?()
    }

    @objc private func didPressCancelButton() {
        onGoBackMainView?()
    }
}


extension SubscriptionView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "termsOfUse" {
            openTermsOfUse()
        }
        return false
    }

    private func openTermsOfUse() {
        didPressTermsOfUser?()
    }
}
