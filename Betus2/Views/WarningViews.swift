

import UIKit
import SnapKit

class WarningViews: UIView {
    private lazy var warningTitle: UILabel = {
        let view = UILabel()
        let attributedText = NSMutableAttributedString()
        let crownImage = UIImage(named: "exclamationMark")?.withRenderingMode(.alwaysOriginal)
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = crownImage
        imageAttachment.image?.withTintColor(.whiteColor)
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 16, height: 16)
        let imageString = NSAttributedString(attachment: imageAttachment)
        attributedText.append(imageString)
        let textString = NSAttributedString(string: "   Warning", attributes: [
            .font: UIFont.goldmanRegular(size: 14),
            .foregroundColor: UIColor.redColor
        ])
        attributedText.append(textString)
        view.attributedText = attributedText
        view.textAlignment = .left
        return view
    }()

    private lazy var warningInfo: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "The workouts presented in the app are recommended and are not professional workouts"
        view.textColor = .redColor
        view.textAlignment = .left
        view.font = UIFont.goldmanRegular(size: 12)
        view.numberOfLines = 0
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
        addSubview(warningTitle)
        addSubview(warningInfo)
    }

    private func setupConstraints() {
        warningTitle.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(14 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(16 * Constraint.xCoeff)
            make.height.equalTo(17 * Constraint.yCoeff)
        }

        warningInfo.snp.remakeConstraints { make in
            make.top.equalTo(warningTitle.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
        }
    }
}
