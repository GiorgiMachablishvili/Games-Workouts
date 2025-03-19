

import UIKit
import SnapKit

class HelperProfileView: UICollectionViewCell {

    var rateButton: (() -> Void)?
    var privacyPolicy: (() -> Void)?
    var terms: (() -> Void)?
    var support: (() -> Void)?
    var restorePurchases: (() -> Void)?

    private lazy var helperProfileView: UIView = {
        let view = UIView(frame: .zero)
        view.makeRoundCorners(32)
        view.backgroundColor = .topBottomViewColorGray
        return view
    }()

    private lazy var privacyPolicyButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Privacy policy", for: .normal)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.titleLabel?.font = UIFont.goldmanRegular(size: 14)
        view.makeRoundCorners(23)
        view.backgroundColor = .grayCalendarPoints
        view.addTarget(self, action: #selector(pressPrivacyPolicyButton), for: .touchUpInside)
        return view
    }()

    private lazy var termsOfUseButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Terms of use", for: .normal)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.titleLabel?.font = UIFont.goldmanRegular(size: 14)
        view.makeRoundCorners(23)
        view.backgroundColor = .grayCalendarPoints
        view.addTarget(self, action: #selector(pressTermsOfUseButton), for: .touchUpInside)
        return view
    }()

    private lazy var rateUsButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Rate US", for: .normal)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.titleLabel?.font = UIFont.goldmanRegular(size: 14)
        view.makeRoundCorners(23)
        view.backgroundColor = .grayCalendarPoints
        view.addTarget(self, action: #selector(pressRateUsButton), for: .touchUpInside)
        return view
    }()

    private lazy var supportButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Support", for: .normal)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.titleLabel?.font = UIFont.goldmanRegular(size: 14)
        view.makeRoundCorners(23)
        view.backgroundColor = .grayCalendarPoints
        view.addTarget(self, action: #selector(pressSupportButton), for: .touchUpInside)
        return view
    }()

//    private lazy var restorePurchasesButton: UIButton = {
//        let view = UIButton(frame: .zero)
//        view.setTitle("Restore purchases", for: .normal)
//        view.setTitleColor(UIColor.whiteColor, for: .normal)
//        view.titleLabel?.font = UIFont.goldmanRegular(size: 14)
//        view.makeRoundCorners(23)
//        view.backgroundColor = .grayCalendarPoints
//        view.addTarget(self, action: #selector(pressRestorePurchasesButton), for: .touchUpInside)
//        return view
//    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(helperProfileView)
        addSubview(privacyPolicyButton)
        addSubview(termsOfUseButton)
        addSubview(rateUsButton)
        addSubview(supportButton)
//        addSubview(restorePurchasesButton)
    }

    private func setupConstraints() {
        helperProfileView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        privacyPolicyButton.snp.remakeConstraints { make in
            make.top.equalTo(helperProfileView.snp.top).offset(16 * Constraint.yCoeff)
            make.leading.trailing.equalTo(helperProfileView).inset(16 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
        }

        termsOfUseButton.snp.remakeConstraints { make in
            make.top.equalTo(privacyPolicyButton.snp.bottom).offset(4 * Constraint.yCoeff)
            make.leading.trailing.equalTo(helperProfileView).inset(16 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
        }

        rateUsButton.snp.remakeConstraints { make in
            make.top.equalTo(termsOfUseButton.snp.bottom).offset(4 * Constraint.yCoeff)
            make.leading.trailing.equalTo(helperProfileView).inset(16 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
        }

        supportButton.snp.remakeConstraints { make in
            make.top.equalTo(rateUsButton.snp.bottom).offset(4 * Constraint.yCoeff)
            make.leading.trailing.equalTo(helperProfileView).inset(16 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
        }

//        restorePurchasesButton.snp.remakeConstraints { make in
//            make.top.equalTo(supportButton.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(44 * Constraint.yCoeff)
//        }
    }

    //TODO: add button functions 
    @objc func pressPrivacyPolicyButton() {
        privacyPolicy?()
    }

    @objc func pressTermsOfUseButton() {
        terms?()
    }
    @objc func pressRateUsButton() {
        rateButton?()
    }

    @objc func pressSupportButton() {
        support?()
    }

//    @objc func pressRestorePurchasesButton() {
//        restorePurchases?()
//    }
}
