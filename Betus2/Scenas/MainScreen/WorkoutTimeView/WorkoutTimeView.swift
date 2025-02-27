

import UIKit
import SnapKit
import Alamofire

class WorkoutTimeView: UIViewController {

    private var timer: Timer?
    private var currentTime = 180
    private var workoutSteps: [ViewInfo] = []
    private var currentStepIndex = 0
    var selectedSport: String?
    var workoutScore: [WorkoutScore] = []


    private lazy var workoutDescriptionTopView: WorkoutDescriptionTopView = {
        let view = WorkoutDescriptionTopView()
        view.backgroundColor = UIColor.topBottomViewColorGray
        view.makeRoundCorners(32)
        return view
    }()

    private lazy var previousTimeBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(hexString: "#151414")
        view.makeRoundCorners(40)
        return view
    }()

    private lazy var previousTimeLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "00:00"
        view.font = UIFont.goldmanRegular(size: 14)
        view.textColor = UIColor.grayCalendarDayName
        view.textAlignment = .center
        return view
    }()

    private lazy var timerBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .redColor.withAlphaComponent(0.2)
        view.makeRoundCorners(80)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var timerBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.red
        view.makeRoundCorners(70)
        return view
    }()

    private lazy var timerLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "03:00"
        view.font = UIFont.boldSystemFont(ofSize: 32)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()

    private lazy var nextWorkoutTimeBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(hexString: "#151414")
        view.makeRoundCorners(40)
        return view
    }()

    private lazy var nextWorkoutTimeLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "00:00"
        view.font = UIFont.goldmanRegular(size: 14)
        view.textColor = UIColor.grayCalendarDayName
        view.textAlignment = .center
        return view
    }()

    private lazy var toggleButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "timersStart"), for: .normal)
        view.addTarget(self, action: #selector(toggleTimer), for: .touchUpInside)
        return view
    }()

    private lazy var completView: CompletView = {
        let view = CompletView()
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()

        selectWorkout()
        configureWorkoutStep()
    }

    private func setup() {
        view.addSubview(workoutDescriptionTopView)
        view.addSubview(timerBackground)
        timerBackground.addSubview(timerBackgroundView)
        timerBackgroundView.addSubview(timerLabel)
        view.addSubview(toggleButton)
        view.addSubview(completView)
        view.addSubview(previousTimeBackground)
        previousTimeBackground.addSubview(previousTimeLabel)
        view.addSubview(nextWorkoutTimeBackground)
        nextWorkoutTimeBackground.addSubview(nextWorkoutTimeLabel)
        view.bringSubviewToFront(toggleButton)
    }


    private func setupConstraints() {
        workoutDescriptionTopView.snp.remakeConstraints { make in
            make.top.equalTo(view.snp.top).offset(48 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(123 * Constraint.yCoeff)
        }

        completView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(260 * Constraint.yCoeff)
        }

        nextWorkoutTimeBackground.snp.remakeConstraints { make in
            make.centerY.equalTo(timerBackground.snp.centerY)
            make.trailing.equalTo(view.snp.trailing).offset(-13 * Constraint.xCoeff)
            make.height.width.equalTo(80 * Constraint.yCoeff)
        }

        nextWorkoutTimeLabel.snp.remakeConstraints { make in
            make.center.equalTo(nextWorkoutTimeBackground.snp.center)
            make.height.equalTo(17 * Constraint.yCoeff)
        }

        previousTimeBackground.snp.remakeConstraints { make in
            make.centerY.equalTo(timerBackground.snp.centerY)
            make.leading.equalTo(view.snp.leading).offset(13 * Constraint.xCoeff)
            make.height.width.equalTo(80 * Constraint.yCoeff)
        }

        previousTimeLabel.snp.remakeConstraints { make in
            make.center.equalTo(previousTimeBackground.snp.center)
            make.height.equalTo(17)
        }

        timerBackground.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(160 * Constraint.yCoeff)
        }

        timerBackgroundView.snp.remakeConstraints { make in
            make.center.equalTo(timerBackground.snp.center)
            make.height.width.equalTo(140 * Constraint.yCoeff)
        }

        timerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        toggleButton.snp.makeConstraints { make in
            make.top.equalTo(timerBackgroundView.snp.bottom).offset(24 * Constraint.yCoeff)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(44 * Constraint.yCoeff)
        }
    }

    private func selectWorkout() {
        if let sport = selectedSport?.uppercased() {
            switch sport {
            case "TENNIS":
                setupTennisWorkoutSteps()
            case "BASKETBALL":
                setupBasketballWorkoutSteps()
            case "VOLLEYBALL":
                setupVolleyballWorkoutSteps()
            case "SOCCER":
                setupSoccerWorkoutSteps()
            default:
                workoutSteps = []
            }
        }
    }

    private func setupTennisWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Jog around the court.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Stretching for legs, back, arms and shoulders.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Serving exercise.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Forehand exercise.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Backhand exercise.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "\("Quick Reaction") mini-game.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "\("Running around the court") exercise.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "A series of shots into a mini box.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Relaxation and stretching.", timer: "3")
        ]
    }

    private func setupBasketballWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Running around the perimeter of the court at a moderate pace.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Stretching for legs, back, arms and shoulders.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Ball exercise:", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Throwing exercise:", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Defense exercise:", timer: "4"),
            ViewInfo(title: "Technique exercises:", description: "Throw blocking exercise.", timer: "2"),
            ViewInfo(title: "Technique exercises:", description: "Ball interceptions exercise.", timer: "2"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Jumping in place and jumping over hurdles.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Running short intervals with changes of pace (sprints, half-speed running, moderate speed running).", timer: "3"),

            ViewInfo(title: "Completion:", description: "Stretching for legs, back, arms and shoulders.", timer: "3"),
            ViewInfo(title: "Completion:", description: "Rest and regain breathing.", timer: "3")
        ]
    }

    private func setupVolleyballWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Running around the court or training area.", timer: "2"),
            ViewInfo(title: "Warm-up:", description: "Stretching for legs, back, arms and shoulders.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Ball serves:", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Passing exercise:", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Attacking exercise:", timer: "4"),
            ViewInfo(title: "Technique exercises:", description: "Hitting the ball into the center with power shots.", timer: "2"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Fast reaction exercise:", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Speed exercise:", timer: "3"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Fast jogging in short intervals.", timer: "2"),

            ViewInfo(title: "Completion:", description: "Stretching for legs, back, arms and shoulders.", timer: "2"),
            ViewInfo(title: "Completion:", description: "Rest and breathing recovery.", timer: "3")
        ]
    }

    private func setupSoccerWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Running around the perimeter of the field at a moderate pace.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Stretching for legs, back, arms and shoulders.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Passing exercise:", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Dribbling exercise:", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Kicking exercise:", timer: "4"),
            ViewInfo(title: "Technique exercises:", description: "Kicks at goal from various positions.", timer: "2"),
            ViewInfo(title: "Technique exercises:", description: "Kicks with a partner, passing the ball for a kick.", timer: "2"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Jumping over hurdles.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Running short intervals with changes of pace (sprints, half-speed running, moderate speed running).", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Stretching exercises for legs, back, arms and shoulders.", timer: "3"),
            ViewInfo(title: "Wrap-up:", description: "Rest and breathing recovery.", timer: "3")
        ]
    }


    private func configureWorkoutStep() {
        guard currentStepIndex < workoutSteps.count else {
            timerLabel.text = "00:00"
            stopTimer()
            completView.isHidden = false
            toggleButton.setImage(UIImage(named: "okeyButton"), for: .normal)

            toggleButton.snp.remakeConstraints { make in
                make.top.equalTo(timerBackgroundView.snp.bottom).offset(24 * Constraint.yCoeff)
                make.centerX.equalToSuperview()
                make.height.equalTo(44 * Constraint.yCoeff)
                make.width.equalTo(69 * Constraint.xCoeff)
            }
            nextWorkoutTimeLabel.text = "00:00"
            nextWorkoutTimeBackground.isHidden = true
            previousTimeLabel.text = "00:00"
            previousTimeBackground.isHidden = true
            return
        }

        let step = workoutSteps[currentStepIndex]
        workoutDescriptionTopView.configure(data: step)
        if let timerValue = Int(step.timer) {
            currentTime = timerValue * 60
        } else {
            currentTime = 0
        }
        timerLabel.text = formatTime(currentTime)
        nextWorkoutTime()
        previousWorkoutTime()
    }

    // Helper: Show an alert to the user
    private func showAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }


    private func nextWorkoutTime() {
        if currentStepIndex + 1 < workoutSteps.count {
            let nextStep = workoutSteps[currentStepIndex + 1]
            nextWorkoutTimeLabel.text = "\(nextStep.timer):00"
        } else {
            nextWorkoutTimeLabel.text = "00:00"
            nextWorkoutTimeBackground.isHidden = true
        }
    }

    private func previousWorkoutTime() {
        if currentStepIndex > 0 {
            let previousStep = workoutSteps[currentStepIndex - 1]
            previousTimeLabel.text = "\(previousStep.timer):00"
            previousTimeBackground.isHidden = false
        } else {
            previousTimeLabel.text = "00:00"
            previousTimeBackground.isHidden = true
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc private func updateTimer() {
        guard currentTime > 0 else {
            stopTimer()
            if currentStepIndex == workoutSteps.count - 1 {
                timerLabel.text = "00:00"
                toggleButton.setImage(UIImage(named: "okeyButton"), for: .normal)
                //                if toggleButton.image(for: .normal) == UIImage(named: "okeyButton") {
                toggleButton.snp.remakeConstraints { make in
                    make.top.equalTo(timerBackgroundView.snp.bottom).offset(24 * Constraint.yCoeff)
                    make.centerX.equalToSuperview()
                    make.height.equalTo(44 * Constraint.yCoeff)
                    make.width.equalTo(69 * Constraint.xCoeff)
                }
                //                }
                completView.isHidden = false
            } else {
                currentStepIndex += 1
                configureWorkoutStep()
            }
            return
        }
        currentTime -= 1
        timerLabel.text = formatTime(currentTime)
    }

    private func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    @objc private func toggleTimer() {
        if toggleButton.image(for: .normal) == UIImage(named: "okeyButton") {
            if let sport = selectedSport?.lowercased() {
                updateWorkoutScore(for: sport)
                updateWorkoutDays()
            }
            navigationController?.popViewController(animated: true)
        } else if timer == nil {
            startTimer()
            toggleButton.setImage(UIImage(named: "timersStop"), for: .normal)
        } else {
            stopTimer()
            toggleButton.setImage(UIImage(named: "timersStart"), for: .normal)
        }
    }

    private func updateWorkoutScore(for sport: String) {
        // Add day/month/year
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let currentDate = dateFormatter.string(from: Date())

        // Add time in AM/PM format
        dateFormatter.dateFormat = "hh:mm a"
        let currentTimeString = dateFormatter.string(from: Date())

        var soccerWorkoutCount = 0
        var basketballWorkoutCount = 0
        var volleyballWorkoutCount = 0
        var tennisWorkoutCount = 0

        // Increment the count based on the sport
        switch sport {
        case "soccer":
            soccerWorkoutCount += 1
        case "basketball":
            basketballWorkoutCount += 1
        case "volleyball":
            volleyballWorkoutCount += 1
        case "tennis":
            tennisWorkoutCount += 1
        default:
            break
        }

        // Create a new WorkoutScore instance
        let newScore = WorkoutScore(
            workoutDate: currentDate,
            soccerWorkoutCount: soccerWorkoutCount,
            basketballWorkoutCount: basketballWorkoutCount,
            volleyballWorkoutCount: volleyballWorkoutCount,
            tennisWorkoutCount: tennisWorkoutCount,
            workoutTime: currentTimeString
        )

        workoutScore.append(newScore)

        postWorkoutScore(newScore)
    }

    //MARK: post workouts current time
    private func postWorkoutScore(_ score: WorkoutScore) {
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? String else {
            return
        }
        let parameters: [String: Any] = [
            "workoutDate": score.workoutDate,
            "soccerWorkoutCount": score.soccerWorkoutCount,
            "basketballWorkoutCount": score.basketballWorkoutCount,
            "volleyballWorkoutCount": score.volleyballWorkoutCount,
            "tennisWorkoutCount": score.tennisWorkoutCount,
            "workout_time": score.workoutTime
        ]

        let url = String.createWorkoutCountsAndDate(userId: userId)
        NetworkManager.shared.showProgressHud(true, animated: true)
        NetworkManager.shared.post(url: url, parameters: parameters, headers: nil) { (result: Result<WorkoutScore>) in
            NetworkManager.shared.showProgressHud(false, animated: false)
            switch result {
            case .success(let workout):
                print("Workout saved successfully: \(workout)")
            case .failure(let error):
                print("Error saving workout: \(error.localizedDescription)")
                print("Request Parameters: \(parameters)")
            }
        }
    }

    private func updateWorkoutDays() {
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? String else {
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())

        let url = String.postWorkoutDaysInARow(userId: userId, date: date)
        NetworkManager.shared.showProgressHud(true, animated: true)
        NetworkManager.shared.post(url: url, parameters: nil, headers: nil) { (result: Result<NumberOfDays>) in
            NetworkManager.shared.showProgressHud(false, animated: false)
            switch result {
            case .success(let workout):
                print("Workout saved successfully: \(workout)")
            case .failure(let error):
                print("Error saving workout: \(error.localizedDescription)")
            }
        }
    }

    func skipStep() {
        currentStepIndex += 1
        stopTimer()
        toggleButton.setImage(UIImage(named: "timersStart"), for: .normal)
        configureWorkoutStep()
    }
}
