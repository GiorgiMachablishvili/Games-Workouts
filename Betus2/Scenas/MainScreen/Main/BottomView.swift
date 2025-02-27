

import UIKit
import SnapKit

protocol BottomViewDelegate: AnyObject {
    func didTapStartButton()
}

class BottomView: UIView {

    weak var delegate: BottomViewDelegate?
    

    private lazy var sportViewTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ""
        view.textColor = UIColor.whiteColor
        view.font = UIFont.goldmanBold(size: 14)
        view.textAlignment = .left
        return view
    }()

    private lazy var sportWorkoutDescription: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ""
        view.textColor = UIColor.grayCalendarDayName
        view.font = UIFont.goldmanRegular(size: 12)
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()

    private lazy var timerImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "timer")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var sportTimeLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.attributedText = makeSportTimeAttributedText(timer: "25")
        view.textAlignment = .left
        return view
    }()

    lazy var startButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Start ", for: .normal)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.titleLabel?.font = UIFont.goldmanRegular(size: 14)
        view.backgroundColor = UIColor.redColor
        view.makeRoundCorners(16)
        let image = UIImage(named: "play")?.withRenderingMode(.alwaysOriginal)
        let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 19, height: 18)).image { _ in
            image?.draw(in: CGRect(origin: .zero, size: CGSize(width: 19, height: 18)))
        }
        view.setImage(resizedImage, for: .normal)
        view.imageView?.contentMode = .scaleAspectFit
        view.semanticContentAttribute = .forceRightToLeft
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        view.contentHorizontalAlignment = .center
        view.addTarget(self, action: #selector(clickStartButton), for: .touchUpInside)

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
        addSubview(sportViewTitle)
        addSubview(sportWorkoutDescription)
        addSubview(timerImage)
        addSubview(sportTimeLabel)
        addSubview(startButton)
    }

    private func setupConstraints() {
        sportViewTitle.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(16 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(16 * Constraint.xCoeff)
            make.height.equalTo(17 * Constraint.yCoeff)
        }

        sportWorkoutDescription.snp.remakeConstraints { make in
            make.top.equalTo(sportViewTitle.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(16 * Constraint.xCoeff)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        timerImage.snp.remakeConstraints { make in
            make.leading.equalTo(snp.leading).offset(16 * Constraint.xCoeff)
            make.bottom.equalTo(snp.bottom).offset(-29 * Constraint.yCoeff)
            make.height.width.equalTo(16 * Constraint.yCoeff)
        }

        sportTimeLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(timerImage.snp.centerY)
            make.leading.equalTo(timerImage.snp.trailing).offset(4 * Constraint.xCoeff)
            make.height.equalTo(17 * Constraint.yCoeff)
        }

        startButton.snp.remakeConstraints { make in
            make.centerY.equalTo(timerImage.snp.centerY)
            make.trailing.equalTo(snp.trailing).offset(-16 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
            make.width.equalTo(87 * Constraint.xCoeff)
        }
    }

    private func makeSportTimeAttributedText(timer: String) -> NSAttributedString {
        let text = "\(timer) min"
        let attributedString = NSMutableAttributedString(string: text)

        let numberRange = (text as NSString).range(of: timer)
        attributedString.addAttributes([
            .foregroundColor: UIColor.white,
            .font: UIFont.goldmanBold(size: 18)
        ], range: numberRange)

        let unitRange = (text as NSString).range(of: "min")
        attributedString.addAttributes([
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.goldmanRegular(size: 14 * Constraint.yCoeff)
        ], range: unitRange)

        return attributedString
    }

    @objc private func clickStartButton() {
        delegate?.didTapStartButton()
    }

    func configure(data: ViewInfo) {
        sportViewTitle.text = data.title
        sportWorkoutDescription.text = data.description
        sportTimeLabel.attributedText = makeSportTimeAttributedText(timer: data.timer)
    }
}
