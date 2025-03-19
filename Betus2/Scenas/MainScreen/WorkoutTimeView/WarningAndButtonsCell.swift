

import UIKit
import SnapKit

class WarningAndButtonsCell: UICollectionViewCell {

    var didPressDeleteButton: (() -> Void)?
    var didPressSignInButton: (() -> Void)?

    private lazy var warningAndButtonsViewBackground: UIView = {
        let view = UIView(frame: .zero)
        view.makeRoundCorners(32)
        view.backgroundColor = UIColor.topBottomViewColorGray
        return view
    }()

    private lazy var warningViewRed: WarningViews = {
        let view = WarningViews()
        view.makeRoundCorners(16)
        view.backgroundColor = .redColor.withAlphaComponent(0.2)
        return view
    }()

    lazy var deleteButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Delete Account", for: .normal)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.titleLabel?.font = UIFont.goldmanRegular(size: 14)
        view.makeRoundCorners(23)
        view.backgroundColor = .topBottomViewColorGray
        view.isHidden = true
        view.addTarget(self, action: #selector(pressDeleteButton), for: .touchUpInside)
        return view
    }()

    lazy var signInButton: UIButton = {
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(warningAndButtonsViewBackground)
        addSubview(warningViewRed)
        addSubview(deleteButton)
        addSubview(signInButton)
    }

    private func setupConstraints() {
        warningAndButtonsViewBackground.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        warningViewRed.snp.remakeConstraints { make in
            make.top.equalTo(warningAndButtonsViewBackground.snp.top).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalTo(warningAndButtonsViewBackground).inset(16 * Constraint.xCoeff)
            make.height.equalTo(81 * Constraint.yCoeff)
        }

        deleteButton.snp.remakeConstraints { make in
            make.top.equalTo(warningViewRed.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalTo(warningAndButtonsViewBackground).inset(16 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
        }

        signInButton.snp.remakeConstraints { make in
            make.top.equalTo(warningViewRed.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalTo(warningAndButtonsViewBackground).inset(16 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
        }
    }

    @objc private func pressDeleteButton() {
        didPressDeleteButton?()
    }

    @objc private func pressSignInButton() {
        didPressSignInButton?()
    }
}
