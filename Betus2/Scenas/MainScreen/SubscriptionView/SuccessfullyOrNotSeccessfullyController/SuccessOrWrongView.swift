

import UIKit
import SnapKit

class SuccessOrWrongView: UIView {

    var onOkeyButton: (() -> Void)?
    var pressSupportButton: (() -> Void)?

    func showSuccessUI() {
        succseeTitle.isHidden = false
        welcomeLabel.isHidden = false
        subscriptionBenefits.isHidden = false

        wrongTitle.isHidden = true
        wrongInfoLabel.isHidden = true
        pointOne.isHidden = true
        featuresLabel.isHidden = true
        pointTwo.isHidden = true
        customLabel.isHidden = true
        supportButton.isHidden = true
    }

    func showFailureUI() {
        succseeTitle.isHidden = true
        welcomeLabel.isHidden = true
        subscriptionBenefits.isHidden = true

        wrongTitle.isHidden = false
        wrongInfoLabel.isHidden = false
        pointOne.isHidden = false
        featuresLabel.isHidden = false
        pointTwo.isHidden = false
        customLabel.isHidden = false
        supportButton.isHidden = false
    }

    private lazy var succseeTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Successfully"
        view.font = UIFont.goldmanBold(size: 36)
        view.numberOfLines = 2
        view.textColor = .whiteColor

        return view
    }()

    private lazy var welcomeLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Welcome to the pro level, new features are now available to you:"
        view.font = UIFont.goldmanBold(size: 12)
        view.numberOfLines = 2
        view.textColor = .grayCalendarDayName

        return view
    }()

//    private lazy var subscriptionBenefits: UIImageView = {
//        let view = UIImageView(frame: .zero)
//        view.image = UIImage(named: "subscrioptionBenefits")
//        view.contentMode = .scaleAspectFit
//        return view
//    }()

    private lazy var subscriptionBenefits: SubscriptionBenefitsView = {
        let view = SubscriptionBenefitsView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var wrongTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Something went wrong"
        view.font = UIFont.goldmanBold(size: 36)
        view.numberOfLines = 2
        view.textColor = .whiteColor
        view.isHidden = true
        return view
    }()

    private lazy var wrongInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "What could have happened:"
        view.font = UIFont.goldmanBold(size: 12)
        view.numberOfLines = 2
        view.textColor = .grayCalendarDayName
        view.isHidden = true
        return view
    }()

    private lazy var pointOne: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(2)
        view.isHidden = true
        return view
    }()

    private lazy var featuresLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Be the first to know about new features"
        view.font = UIFont.goldmanBold(size: 12)
        view.numberOfLines = 2
        view.textColor = .whiteColor
        view.isHidden = true
        return view
    }()

    private lazy var pointTwo: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(2)
        view.isHidden = true
        return view
    }()

    private lazy var customLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Contact customer"
        view.font = UIFont.goldmanBold(size: 12)
        view.textColor = .whiteColor
        view.isHidden = true
        return view
    }()

    private lazy var supportButton: UIButton = {
        let view = UIButton(frame: .zero)
        let attributedTitle = NSAttributedString(
            string: "support",
            attributes: [
                .font: UIFont.goldmanRegular(size: 12),
                .foregroundColor: UIColor.grayCalendarDayName,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        view.setAttributedTitle(attributedTitle, for: .normal)
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(didPressSupportButton), for: .touchUpInside)
        view.isHidden = true
        return view
    }()

    private lazy var okeyButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Okey", for: .normal)
        view.backgroundColor = .redColor
        view.makeRoundCorners(16)
        view.titleLabel?.font = UIFont.goldmanRegular(size: 14)
        view.titleLabel?.textColor = UIColor.whiteColor
        view.addTarget(self, action: #selector(didPressOkeyButtonButton), for: .touchUpInside)
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
        addSubview(succseeTitle)
        addSubview(welcomeLabel)
        addSubview(subscriptionBenefits)
        addSubview(okeyButton)
        addSubview(wrongTitle)
        addSubview(wrongInfoLabel)
        addSubview(pointOne)
        addSubview(featuresLabel)
        addSubview(pointTwo)
        addSubview(customLabel)
        addSubview(supportButton)
    }

    private func setupConstraints() {
        succseeTitle.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(24 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.greaterThanOrEqualTo(43 * Constraint.yCoeff)
        }

        wrongTitle.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(24 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.greaterThanOrEqualTo(43 * Constraint.yCoeff)
        }

        welcomeLabel.snp.remakeConstraints { make in
            make.top.equalTo(succseeTitle.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.lessThanOrEqualTo(32 * Constraint.yCoeff)
        }

        wrongInfoLabel.snp.remakeConstraints { make in
            make.top.equalTo(wrongTitle.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.lessThanOrEqualTo(32 * Constraint.yCoeff)
        }

        okeyButton.snp.remakeConstraints { make in
            make.bottom.equalTo(snp.bottom).offset(-16 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(48 * Constraint.yCoeff)
        }

        subscriptionBenefits.snp.remakeConstraints { make in
            make.bottom.equalTo(okeyButton.snp.top).offset(-32 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(64 * Constraint.yCoeff)
        }

        pointOne.snp.remakeConstraints { make in
            make.bottom.equalTo(pointTwo.snp.top).offset(-15 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(20 * Constraint.xCoeff)
            make.height.width.equalTo(4 * Constraint.yCoeff)
        }

        featuresLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(pointOne.snp.centerY)
            make.leading.equalTo(pointOne.snp.trailing).offset(10 * Constraint.xCoeff)
            make.height.equalTo(14 * Constraint.yCoeff)
        }

        pointTwo.snp.remakeConstraints { make in
            make.bottom.equalTo(okeyButton.snp.top).offset(-39 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(20 * Constraint.xCoeff)
            make.height.width.equalTo(4 * Constraint.yCoeff)
        }

        customLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(pointTwo.snp.centerY)
            make.leading.equalTo(pointOne.snp.trailing).offset(10 * Constraint.xCoeff)
            make.height.equalTo(14 * Constraint.yCoeff)
        }

        supportButton.snp.remakeConstraints { make in
            make.centerY.equalTo(pointTwo.snp.centerY)
            make.leading.equalTo(customLabel.snp.trailing).offset(3 * Constraint.xCoeff)
            make.height.equalTo(14 * Constraint.yCoeff)
        }

    }

    @objc private func didPressOkeyButtonButton() {
        onOkeyButton?()
    }

    @objc private func didPressSupportButton() {
        pressSupportButton?()
    }
}
