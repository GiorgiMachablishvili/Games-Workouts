

import UIKit
import SnapKit

class TrainingStaticView: UIView {

    var onBackButtonTap: (() -> Void)?

    private lazy var backButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "backArrow"), for: .normal)
        view.addTarget(self, action: #selector(pressBackButton), for: .touchUpInside)
        return view
    }()

    private lazy var trainingScoreTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Your training statistics"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.goldmanBold(size: 16)
        view.textAlignment = .center
        return view
    }()

    lazy var soccerView = CustomWorkoutsView.createCustomView(
            imageName: "soccer",
            titleText: "Soccer",
            pointText: "0",
            titleFont: UIFont.goldmanRegular(size: 14),
            pointFont: UIFont.goldmanRegular(size: 14),
            textColor: .white
        )

    private lazy var soccerBottomLine: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .grayCalendarPoints
        return view
    }()

    lazy var volleyballView = CustomWorkoutsView.createCustomView(
            imageName: "volleyball",
            titleText: "Volleyball",
            pointText: "0",
            titleFont: UIFont.goldmanRegular(size: 14),
            pointFont: UIFont.goldmanRegular(size: 14),
            textColor: .white
        )

    private lazy var volleyballBottomLine: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .grayCalendarPoints
        return view
    }()

    lazy var basketballView = CustomWorkoutsView.createCustomView(
            imageName: "basketball",
            titleText: "Basketball",
            pointText: "0",
            titleFont: UIFont.goldmanRegular(size: 14),
            pointFont: UIFont.goldmanRegular(size: 14),
            textColor: .white
        )

    private lazy var basketballBottomLine: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .grayCalendarPoints
        return view
    }()

    lazy var tennisView = CustomWorkoutsView.createCustomView(
            imageName: "tennis",
            titleText: "Tennis",
            pointText: "0",
            titleFont: UIFont.goldmanRegular(size: 14),
            pointFont: UIFont.goldmanRegular(size: 14),
            textColor: .white
        )

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(backButton)
        addSubview(trainingScoreTitle)
        addSubview(soccerView)
        addSubview(soccerBottomLine)
        addSubview(volleyballView)
        addSubview(volleyballBottomLine)
        addSubview(basketballView)
        addSubview(basketballBottomLine)
        addSubview(tennisView)
    }


    private func setupConstraints() {
        backButton.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(16 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(16 * Constraint.xCoeff)
            make.height.width.equalTo(32 * Constraint.yCoeff)
        }

        trainingScoreTitle.snp.remakeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(4 * Constraint.yCoeff)
            make.height.width.equalTo(19 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(65 * Constraint.xCoeff)
        }

        soccerView.snp.remakeConstraints { make in
            make.top.equalTo(trainingScoreTitle.snp.bottom).offset(16 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(33 * Constraint.yCoeff)
        }

        soccerBottomLine.snp.remakeConstraints { make in
            make.top.equalTo(soccerView.snp.bottom).offset(1 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(1 * Constraint.yCoeff)
        }

        volleyballView.snp.remakeConstraints { make in
            make.top.equalTo(soccerView.snp.bottom).offset(4 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(33 * Constraint.yCoeff)
        }

        volleyballBottomLine.snp.remakeConstraints { make in
            make.top.equalTo(volleyballView.snp.bottom).offset(1 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(1 * Constraint.xCoeff)
            make.height.equalTo(1 * Constraint.yCoeff)
        }

        basketballView.snp.remakeConstraints { make in
            make.top.equalTo(volleyballView.snp.bottom).offset(4 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(33 * Constraint.yCoeff)
        }

        basketballBottomLine.snp.remakeConstraints { make in
            make.top.equalTo(basketballView.snp.bottom).offset(12 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(1 * Constraint.yCoeff)
        }

        tennisView.snp.remakeConstraints { make in
            make.top.equalTo(basketballView.snp.bottom).offset(4 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(33 * Constraint.yCoeff)
        }
    }

    @objc func pressBackButton() {
        onBackButtonTap?()
    }

    func updateWorkoutPoints(soccer: Int, volleyball: Int, basketball: Int, tennis: Int) {
        soccerView.updatePointText("\(soccer)")
        volleyballView.updatePointText("\(volleyball)")
        basketballView.updatePointText("\(basketball)")
        tennisView.updatePointText("\(tennis)")
    }
}

