




import UIKit
import SnapKit

class TrainingStaticView: UICollectionViewCell {

    var onBackButtonTap: (() -> Void)?

    private lazy var trainingStaticBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.makeRoundCorners(32)
        view.backgroundColor = UIColor.topBottomViewColorGray
        return view
    }()

    private lazy var backButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "backArrow"), for: .normal)
        view.addTarget(self, action: #selector(pressBackButton), for: .touchUpInside)
        return view
    }()

    private lazy var trainingScoreTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Your training statistics"
        view.textColor = UIColor.white
        view.font = UIFont.goldmanBold(size: 16)
        view.textAlignment = .center
        return view
    }()

    // Dictionary to store workout views dynamically
    private var workoutViews: [String: CustomWorkoutsView] = [:]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(trainingStaticBackgroundView)
        addSubview(backButton)
        addSubview(trainingScoreTitle)

        let sports = [
            "soccer", "volleyball", "basketball", "tennis",
            "americanFootball", "badminton", "baseball", "rugby",
            "boxing", "cycling", "golf", "gymnastics", "iceHockey",
            "lacrosse", "mma", "wrestling", "rowing", "running",
            "swimming", "tableTennis"
        ]

        for sport in sports {
            let view = CustomWorkoutsView.createCustomView(
                imageName: sport,
                titleText: sport.capitalized,
                pointText: "0",
                titleFont: UIFont.goldmanRegular(size: 14),
                pointFont: UIFont.goldmanRegular(size: 14),
                textColor: .whiteColor
            )
            workoutViews[sport] = view
            addSubview(view)
        }
    }

    private func setupConstraints() {
        trainingStaticBackgroundView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        backButton.snp.makeConstraints { make in
            make.top.equalTo(trainingStaticBackgroundView.snp.top).offset(16 * Constraint.yCoeff)
            make.leading.equalTo(trainingStaticBackgroundView.snp.leading).offset(16 * Constraint.xCoeff)
            make.height.width.equalTo(32 * Constraint.yCoeff)
        }

        trainingScoreTitle.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(4 * Constraint.yCoeff)
            make.leading.trailing.equalTo(trainingStaticBackgroundView).inset(65 * Constraint.xCoeff)
            make.height.equalTo(19 * Constraint.yCoeff)
        }

        var previousView: UIView = trainingScoreTitle
        for (_, view) in workoutViews {
            view.snp.makeConstraints { make in
                make.top.equalTo(previousView.snp.bottom).offset(8 * Constraint.yCoeff)
                make.leading.trailing.equalTo(trainingStaticBackgroundView).inset(16 * Constraint.xCoeff)
                make.height.equalTo(33 * Constraint.yCoeff)
            }
            previousView = view
        }
    }

    @objc func pressBackButton() {
        onBackButtonTap?()
    }

    func updateWorkoutPoints(points: [String: Int]) {
        for (sport, view) in workoutViews {
            if let score = points[sport] {
                view.updatePointText("\(score)")
            }
        }
    }
}


//
//import UIKit
//import SnapKit
//
//class TrainingStaticView: UICollectionViewCell {
//
//    var onBackButtonTap: (() -> Void)?
//
//    private lazy var backButton: UIButton = {
//        let view = UIButton(frame: .zero)
//        view.setImage(UIImage(named: "backArrow"), for: .normal)
//        view.addTarget(self, action: #selector(pressBackButton), for: .touchUpInside)
//        return view
//    }()
//
//    private lazy var trainingScoreTitle: UILabel = {
//        let view = UILabel(frame: .zero)
//        view.text = "Your training statistics"
//        view.textColor = UIColor.whiteColor
//        view.font = UIFont.goldmanBold(size: 16)
//        view.textAlignment = .center
//        return view
//    }()
//
//    lazy var soccerView = CustomWorkoutsView.createCustomView(
//            imageName: "soccer",
//            titleText: "Soccer",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var soccerBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var volleyballView = CustomWorkoutsView.createCustomView(
//            imageName: "volleyball",
//            titleText: "Volleyball",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var volleyballBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var basketballView = CustomWorkoutsView.createCustomView(
//            imageName: "basketball",
//            titleText: "Basketball",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var basketballBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var tennisView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var tennisBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var americanFootballView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var americanFootballBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var badmintonView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var badmintonBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var baseballView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var baseballBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var rugbyView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var rugbyBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var boxingView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var boxingBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var cyclingView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var cyclingBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var golfView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var golfBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var gymnasticsView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var gymnasticsBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var iceHockeyView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var iceHockeyBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var lacrosseView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var lacrosseBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var mmaView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var mmaBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var wrestlingView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var wrestlingBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var rowingView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var rowingBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var runningView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var runningBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var swimmingView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    private lazy var swimmingBottomLine: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .grayCalendarPoints
//        return view
//    }()
//
//    lazy var tableTennisView = CustomWorkoutsView.createCustomView(
//            imageName: "tennis",
//            titleText: "Tennis",
//            pointText: "0",
//            titleFont: UIFont.goldmanRegular(size: 14),
//            pointFont: UIFont.goldmanRegular(size: 14),
//            textColor: .white
//        )
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        setup()
//        setupConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setup() {
//        addSubview(backButton)
//        addSubview(trainingScoreTitle)
//        addSubview(soccerView)
//        addSubview(soccerBottomLine)
//        addSubview(volleyballView)
//        addSubview(volleyballBottomLine)
//        addSubview(basketballView)
//        addSubview(basketballBottomLine)
//        addSubview(tennisView)
//        addSubview(tennisBottomLine)
//        addSubview(americanFootballView)
//        addSubview(americanFootballBottomLine)
//        addSubview(badmintonView)
//        addSubview(badmintonBottomLine)
//        addSubview(baseballView)
//        addSubview(baseballBottomLine)
//        addSubview(rugbyView)
//        addSubview(rugbyBottomLine)
//        addSubview(boxingView)
//        addSubview(boxingBottomLine)
//        addSubview(cyclingView)
//        addSubview(cyclingBottomLine)
//        addSubview(golfView)
//        addSubview(golfBottomLine)
//        addSubview(gymnasticsView)
//        addSubview(gymnasticsBottomLine)
//        addSubview(iceHockeyView)
//        addSubview(iceHockeyBottomLine)
//        addSubview(lacrosseView)
//        addSubview(lacrosseBottomLine)
//        addSubview(mmaView)
//        addSubview(mmaBottomLine)
//        addSubview(wrestlingView)
//        addSubview(wrestlingBottomLine)
//        addSubview(rowingView)
//        addSubview(rowingBottomLine)
//        addSubview(runningView)
//        addSubview(runningBottomLine)
//        addSubview(swimmingView)
//        addSubview(swimmingBottomLine)
//        addSubview(tableTennisView)
//    }
//
//
//    private func setupConstraints() {
//        backButton.snp.remakeConstraints { make in
//            make.top.equalTo(snp.top).offset(16 * Constraint.yCoeff)
//            make.leading.equalTo(snp.leading).offset(16 * Constraint.xCoeff)
//            make.height.width.equalTo(32 * Constraint.yCoeff)
//        }
//
//        trainingScoreTitle.snp.remakeConstraints { make in
//            make.top.equalTo(backButton.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.height.width.equalTo(19 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(65 * Constraint.xCoeff)
//        }
//
//        soccerView.snp.remakeConstraints { make in
//            make.top.equalTo(trainingScoreTitle.snp.bottom).offset(16 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        soccerBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(soccerView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        volleyballView.snp.remakeConstraints { make in
//            make.top.equalTo(soccerView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        volleyballBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(volleyballView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        basketballView.snp.remakeConstraints { make in
//            make.top.equalTo(volleyballView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        basketballBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(basketballView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        tennisView.snp.remakeConstraints { make in
//            make.top.equalTo(basketballView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        tennisBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(tennisView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        americanFootballView.snp.remakeConstraints { make in
//            make.top.equalTo(tennisView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        americanFootballBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(americanFootballView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        badmintonView.snp.remakeConstraints { make in
//            make.top.equalTo(americanFootballView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        badmintonBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(badmintonView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        baseballView.snp.remakeConstraints { make in
//            make.top.equalTo(badmintonView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        baseballBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(baseballView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        rugbyView.snp.remakeConstraints { make in
//            make.top.equalTo(baseballView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        rugbyBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(rugbyView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        boxingView.snp.remakeConstraints { make in
//            make.top.equalTo(rugbyView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        boxingBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(boxingView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        cyclingView.snp.remakeConstraints { make in
//            make.top.equalTo(boxingView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        cyclingBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(cyclingView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        golfView.snp.remakeConstraints { make in
//            make.top.equalTo(cyclingView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        golfBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(golfView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        gymnasticsView.snp.remakeConstraints { make in
//            make.top.equalTo(golfView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        gymnasticsBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(gymnasticsView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        iceHockeyView.snp.remakeConstraints { make in
//            make.top.equalTo(gymnasticsView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        iceHockeyBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(iceHockeyView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        lacrosseView.snp.remakeConstraints { make in
//            make.top.equalTo(iceHockeyView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        lacrosseBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(lacrosseView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        mmaView.snp.remakeConstraints { make in
//            make.top.equalTo(lacrosseView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        mmaBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(mmaView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        wrestlingView.snp.remakeConstraints { make in
//            make.top.equalTo(mmaView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        wrestlingBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(wrestlingView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        rowingView.snp.remakeConstraints { make in
//            make.top.equalTo(wrestlingView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        rowingBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(rowingView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        runningView.snp.remakeConstraints { make in
//            make.top.equalTo(rowingView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        runningBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(runningView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        swimmingView.snp.remakeConstraints { make in
//            make.top.equalTo(runningView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//
//        swimmingBottomLine.snp.remakeConstraints { make in
//            make.top.equalTo(swimmingView.snp.bottom).offset(1 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(1 * Constraint.yCoeff)
//        }
//
//        tableTennisView.snp.remakeConstraints { make in
//            make.top.equalTo(swimmingView.snp.bottom).offset(4 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
//            make.height.equalTo(33 * Constraint.yCoeff)
//        }
//    }
//
//    @objc func pressBackButton() {
//        onBackButtonTap?()
//    }
//
////    func updateWorkoutPoints(soccer: Int, volleyball: Int, basketball: Int, tennis: Int) {
////        soccerView.updatePointText("\(soccer)")
////        volleyballView.updatePointText("\(volleyball)")
////        basketballView.updatePointText("\(basketball)")
////        tennisView.updatePointText("\(tennis)")
////    }
//
//    func updateWorkoutPoints(points: [String: Int]) {
//        let sportsViews: [String: CustomWorkoutsView] = [
//            "soccer": soccerView,
//            "volleyball": volleyballView,
//            "basketball": basketballView,
//            "tennis": tennisView,
//            "americanFootball": americanFootballView,
//            "badminton": badmintonView,
//            "baseball": baseballView,
//            "rugby": rugbyView,
//            "boxing": boxingView,
//            "cycling": cyclingView,
//            "golf": golfView,
//            "gymnastics": gymnasticsView,
//            "iceHockey": iceHockeyView,
//            "lacrosse": lacrosseView,
//            "mma": mmaView,
//            "wrestling": wrestlingView,
//            "rowing": rowingView,
//            "running": runningView,
//            "swimming": swimmingView,
//            "tableTennis": tableTennisView
//        ]
//
//        for (sport, view) in sportsViews {
//            if let score = points[sport] {
//                view.updatePointText("\(score)")
//            }
//        }
//    }
//}
//
