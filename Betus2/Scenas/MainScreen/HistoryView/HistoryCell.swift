

import UIKit
import SnapKit

class HistoryCell: UICollectionViewCell {
    private lazy var wrapperView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()

    private lazy var backgroundHistoryView: UIView = {
        let view = UIView(frame: .zero)
        view.makeRoundCorners(32)
        view.backgroundColor = .topBottomViewColorGray
        return view
    }()

    private lazy var currentDay: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "27/12/2024"
        view.font = UIFont.goldmanBold(size: 16)
        view.textColor = .whiteColor
        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [soccerView, volleyballView, basketballView, tennisView])
        view.axis = .vertical
        view.spacing = 22 * Constraint.yCoeff
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()

    private lazy var soccerView: UIView = createWorkoutView(imageName: "soccer", title: "Soccer")
    private lazy var volleyballView: UIView = createWorkoutView(imageName: "volleyball", title: "Volleyball")
    private lazy var basketballView: UIView = createWorkoutView(imageName: "basketball", title: "Basketball")
    private lazy var tennisView: UIView = createWorkoutView(imageName: "tennis", title: "Tennis")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(wrapperView)
        wrapperView.addSubview(backgroundHistoryView)
        backgroundHistoryView.addSubview(currentDay)
        backgroundHistoryView.addSubview(stackView)
    }

    private func setupConstraints() {
        wrapperView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(211 * Constraint.yCoeff)
        }

        backgroundHistoryView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        currentDay.snp.remakeConstraints { make in
            make.centerX.equalTo(backgroundHistoryView.snp.centerX)
            make.top.equalTo(backgroundHistoryView.snp.top).offset(16 * Constraint.yCoeff)
            make.height.equalTo(19 * Constraint.yCoeff)
        }

        stackView.snp.remakeConstraints { make in
            make.top.equalTo(currentDay.snp.bottom).offset(16 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.bottom.lessThanOrEqualTo(backgroundHistoryView.snp.bottom).offset(-16 * Constraint.yCoeff)
        }
    }

    private func createWorkoutView(imageName: String, title: String) -> UIView {
        return CustomWorkoutsView.createCustomView(
            imageName: imageName,
            titleText: title,
            pointText: "",
            titleFont: UIFont.goldmanRegular(size: 14),
            pointFont: UIFont.goldmanRegular(size: 14),
            textColor: .white
        )
    }

    private func updatePointLabel(in containerView: UIView, with text: String) {
        if let pointLabel = containerView.viewWithTag(1001) as? UILabel {
            pointLabel.text = text
            containerView.isHidden = text.isEmpty
        }
    }

    func configure(with data: WorkoutScore) {
        currentDay.text = data.workoutDate
        updatePointLabel(in: soccerView, with: data.soccerWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: basketballView, with: data.basketballWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: volleyballView, with: data.volleyballWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: tennisView, with: data.tennisWorkoutCount > 0 ? data.workoutTime : "")

        // Adjust the height dynamically based on visibility
        var totalHeight = 51 * Constraint.yCoeff
            if !soccerView.isHidden { totalHeight += 33 * Constraint.yCoeff }
            if !basketballView.isHidden { totalHeight += 33 * Constraint.yCoeff }
            if !volleyballView.isHidden { totalHeight += 33 * Constraint.yCoeff }
            if !tennisView.isHidden { totalHeight += 33 * Constraint.yCoeff }

            // Update wrapperView height
        wrapperView.snp.updateConstraints { make in
            make.height.equalTo(totalHeight)
        }

        setNeedsLayout()
        layoutIfNeeded()
    }
}
