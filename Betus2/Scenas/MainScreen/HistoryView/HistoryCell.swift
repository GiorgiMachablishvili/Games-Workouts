

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
        let view = UIStackView(arrangedSubviews: [soccerView, volleyballView, basketballView, tennisView, americanFootballView, badmintonView, baseballView, rugbyView, boxingView, cyclingView, golfView, gymnasticsView, iceHockeyView, lacrosseView, mmaView, wrestlingView, rowingView, runningView, swimmingView, tableTennisView])
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
    private lazy var americanFootballView: UIView = createWorkoutView(imageName: "americanFootball", title: "AmericanFootball")
    private lazy var badmintonView: UIView = createWorkoutView(imageName: "badminton", title: "Badminton")
    private lazy var baseballView: UIView = createWorkoutView(imageName: "baseball", title: "Baseball")
    private lazy var rugbyView: UIView = createWorkoutView(imageName: "rugby", title: "Rugby")
    private lazy var boxingView: UIView = createWorkoutView(imageName: "boxing", title: "Boxing")
    private lazy var cyclingView: UIView = createWorkoutView(imageName: "cycling", title: "Cycling")
    private lazy var golfView: UIView = createWorkoutView(imageName: "golf", title: "Golf")
    private lazy var gymnasticsView: UIView = createWorkoutView(imageName: "gymnastics", title: "Gymnastics")
    private lazy var iceHockeyView: UIView = createWorkoutView(imageName: "iceHockey", title: "IceHockey")
    private lazy var lacrosseView: UIView = createWorkoutView(imageName: "lacrosse", title: "Lacrosse")
    private lazy var mmaView: UIView = createWorkoutView(imageName: "mma", title: "MMA")
    private lazy var wrestlingView: UIView = createWorkoutView(imageName: "wrestling", title: "Wrestling")
    private lazy var rowingView: UIView = createWorkoutView(imageName: "rowing", title: "Rowing")
    private lazy var runningView: UIView = createWorkoutView(imageName: "running", title: "Running")
    private lazy var swimmingView: UIView = createWorkoutView(imageName: "swimming", title: "Swimming")
    private lazy var tableTennisView: UIView = createWorkoutView(imageName: "tableTennis", title: "TableTennis")


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
        updatePointLabel(in: americanFootballView, with: data.americanFootballWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: badmintonView, with: data.badmintonWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: baseballView, with: data.baseballWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: rugbyView, with: data.rugbyWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: boxingView, with: data.boxingWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: cyclingView, with: data.cyclingWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: golfView, with: data.golfWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: gymnasticsView, with: data.gymnasticsWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: iceHockeyView, with: data.iceHockeyWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: lacrosseView, with: data.lacrosseWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: mmaView, with: data.mmaWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: wrestlingView, with: data.wrestlingWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: rowingView, with: data.rowingWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: runningView, with: data.runningWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: swimmingView, with: data.swimmingWorkoutCount > 0 ? data.workoutTime : "")
        updatePointLabel(in: tableTennisView, with: data.tableTennisWorkoutCount > 0 ? data.workoutTime : "")

        // Adjust the height dynamically based on visibility
        var totalHeight = 51 * Constraint.yCoeff
        if !soccerView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !basketballView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !volleyballView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !tennisView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !americanFootballView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !badmintonView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !baseballView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !rugbyView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !boxingView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !cyclingView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !golfView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !gymnasticsView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !iceHockeyView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !lacrosseView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !mmaView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !wrestlingView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !rowingView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !runningView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !swimmingView.isHidden { totalHeight += 33 * Constraint.yCoeff }
        if !tableTennisView.isHidden { totalHeight += 33 * Constraint.yCoeff }

        // Update wrapperView height
        wrapperView.snp.updateConstraints { make in
            make.height.equalTo(totalHeight)
        }

        setNeedsLayout()
        layoutIfNeeded()
    }
}
