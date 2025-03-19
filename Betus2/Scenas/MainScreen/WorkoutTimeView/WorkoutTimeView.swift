

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
            case "BASEBALL":
                setupBaseballWorkoutSteps()
            case "SWIMMING":
                setupSwimmingWorkoutSteps()
            case "AMERICANFOOTBALL":
                setupAmericanFootballWorkoutSteps()
            case "CYCLING":
                setupCyclingWorkoutSteps()
            case "BOXING":
                setupBoxingWorkoutSteps()
            case "GOLF":
                setupGolfWorkoutSteps()
            case "RUNNING":
                setupRunWorkoutSteps()
            case "WRESTLING":
                setupWrestlingWorkoutSteps()
            case "GYMNASTICS":
                setupGymnasticsWorkoutSteps()
            case "TABLETENNIS":
                setupTableTennisWorkoutSteps()
            case "ICEHOCKEY":
                setupIceHockeyWorkoutSteps()
            case "RUGBY":
                setupRugbyWorkoutSteps()
            case "MMA":
                setupMMAWorkoutSteps()
            case "ROWING":
                setupRowingWorkoutSteps()
            case "LACROSSE":
                setupLacrosseWorkoutSteps()
            case "BADMINTON":
                setupBadmintonWorkoutSteps()
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

    private func setupBaseballWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Jog around the bases.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Arm circles and shoulder stretching.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Batting stance and swing drills.", timer: "4"),
            ViewInfo(title: "Technique exercises:", description: "Throwing accuracy drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Fielding ground balls.", timer: "3"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Sprint between bases.", timer: "3"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Quick glove reaction drill.", timer: "2"),

            ViewInfo(title: "Wrap-up:", description: "Batting practice with live pitching.", timer: "3"),
            ViewInfo(title: "Wrap-up:", description: "Cool down stretches.", timer: "3")
        ]
    }

    private func setupSwimmingWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Light swimming with freestyle stroke.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Dynamic stretching for shoulders and legs.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Freestyle stroke technique.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Backstroke technique.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Breaststroke kick practice.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Underwater push-off sprint.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "50m sprint swim.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Easy floating and stretching.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Cooldown with slow laps.", timer: "3")
        ]
    }

    private func setupAmericanFootballWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "High knees and butt kicks.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Arm and leg dynamic stretches.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Throwing accuracy drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Footwork agility ladder.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Tackling form drills.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Cone drill for quick turns.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Sprint drills with direction change.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Short pass and catch drills.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Cool down stretches.", timer: "3")
        ]
    }

    private func setupCyclingWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Light pedaling at low resistance.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Stretching for legs and lower back.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Cadence control drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Hill climb simulation.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Sprint interval training.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Fast pedaling drill.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Quick gear shifting challenge.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Cool-down ride at low intensity.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Full-body stretching.", timer: "3")
        ]
    }

    private func setupBoxingWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Jump rope drill.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Shadow boxing with light movements.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Jab and cross combination drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Footwork agility drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Uppercut and hook punch practice.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Reflex reaction drill with coach.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Speed punching bag workout.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Slow shadow boxing and breathing control.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Cool down with full-body stretching.", timer: "3")
        ]
    }

    private func setupGolfWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Gentle swings with a club.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Shoulder and wrist mobility exercises.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Grip and stance alignment practice.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Swing tempo drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Chipping accuracy practice.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Target aiming under time pressure.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Putting challenge with countdown timer.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Slow swings for relaxation.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Stretching for shoulders and lower back.", timer: "3")
        ]
    }

    private func setupRunWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Light jogging and dynamic stretching.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "High knees and butt kicks.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Acceleration drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Sprint form technique.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Starting block practice.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Quick reaction to starting signal.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "30m sprint challenge.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Jogging cooldown.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Full-body stretching.", timer: "3")
        ]
    }

    private func setupWrestlingWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Light jogging and stretching.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Neck and shoulder mobility drills.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Takedown drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Escape technique practice.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Pinning control drills.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Reflex partner drill.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Quick reaction stance changes.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Slow rolling to relax muscles.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Deep stretching for flexibility.", timer: "3")
        ]
    }

    private func setupGymnasticsWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Light stretching and mobility drills.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Basic handstand and balance work.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Cartwheel practice.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Parallel bars technique.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Floor routine drills.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Quick balance recovery drills.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Fast transition exercises.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Gentle stretching and relaxation.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Slow deep breathing techniques.", timer: "3")
        ]
    }

    private func setupTableTennisWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Light jogging and arm stretches.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Shadow swings for forehand and backhand.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Forehand drive practice.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Backhand loop drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Footwork movement drill.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Quick rally challenge.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Fast spin return drill.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Relaxed ball control practice.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Wrist and shoulder stretches.", timer: "3")
        ]
    }

    private func setupIceHockeyWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Skating warm-up laps.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Stickhandling drills while skating.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Slapshot accuracy drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Defensive stance and movement.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Passing under pressure drill.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Puck reaction training.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Fast skating sprints.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Slow skating and deep breathing.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Stretching for legs and shoulders.", timer: "3")
        ]
    }

    private func setupRugbyWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Light jogging and mobility drills.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Dynamic stretching for legs and shoulders.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Passing accuracy drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Tackling technique practice.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Scrum formation and pressure drill.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Agility cone drills.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Sprint and reaction drills.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Short passing challenge.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Stretching and breathing exercises.", timer: "3")
        ]
    }

    private func setupMMAWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Jump rope warm-up.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Shadowboxing with light movement.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Jab-cross combination drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Grappling takedown practice.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Kick and knee strike drill.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Reflex partner drill.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Quick defense reaction training.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Light sparring for cooldown.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Deep stretching and breathing.", timer: "3")
        ]
    }

    private func setupRowingWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Slow rowing at low resistance.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Dynamic stretching for back and legs.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Proper stroke technique drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Drive and recovery phase focus.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Power stroke challenge.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "30-second sprint row.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Fast start and slow finish drill.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Gentle rowing cooldown.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Full-body stretching.", timer: "3")
        ]
    }

    private func setupLacrosseWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Light jogging and stick control drill.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Stretching for legs and shoulders.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Passing accuracy drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Dodging and movement drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Shot accuracy and power practice.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Quick catch and pass challenge.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Sprint between goalposts.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Relaxed stick handling drill.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Cool down with stretching.", timer: "3")
        ]
    }

    private func setupBadmintonWorkoutSteps() {
        workoutSteps = [
            ViewInfo(title: "Warm-up:", description: "Light jogging and shoulder rotations.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Shadow swings for forehand and backhand.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Drop shot and clear drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Footwork agility drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Smash and net shot practice.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Quick rally reaction drill.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Fast shuttle return challenge.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Light rally and movement cooldown.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Wrist and shoulder stretching.", timer: "3")
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
        var americanFootballWorkoutCount = 0
        var badmintonWorkoutCount = 0
        var baseballWorkoutCount = 0
        var rugbyWorkoutCount = 0
        var boxingWorkoutCount = 0
        var cyclingWorkoutCount = 0
        var golfWorkoutCount = 0
        var gymnasticsWorkoutCount = 0
        var iceHockeyWorkoutCount = 0
        var lacrosseWorkoutCount = 0
        var mmaWorkoutCount = 0
        var wrestlingWorkoutCount = 0
        var rowingWorkoutCount = 0
        var runningWorkoutCount = 0
        var swimmingWorkoutCount = 0
        var tableTennisWorkoutCount = 0

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
        case "americanfootball":
            americanFootballWorkoutCount += 1
        case "badminton":
            badmintonWorkoutCount += 1
        case "baseball":
            baseballWorkoutCount += 1
        case "rugby":
            rugbyWorkoutCount += 1
        case "boxing":
            boxingWorkoutCount += 1
        case "cycling":
            cyclingWorkoutCount += 1
        case "golf":
            golfWorkoutCount += 1
        case "gymnastics":
            gymnasticsWorkoutCount += 1
        case "icehockey":
            iceHockeyWorkoutCount += 1
        case "lacrosse":
            lacrosseWorkoutCount += 1
        case "mma":
            mmaWorkoutCount += 1
        case "wrestling":
            wrestlingWorkoutCount += 1
        case "rowing":
            rowingWorkoutCount += 1
        case "running":
            runningWorkoutCount += 1
        case "swimming":
            swimmingWorkoutCount += 1
        case "tabletennis":
            tableTennisWorkoutCount += 1
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
            americanFootballWorkoutCount: americanFootballWorkoutCount,
            badmintonWorkoutCount: badmintonWorkoutCount,
            baseballWorkoutCount: baseballWorkoutCount,
            rugbyWorkoutCount: rugbyWorkoutCount,
            boxingWorkoutCount: boxingWorkoutCount,
            cyclingWorkoutCount: cyclingWorkoutCount,
            golfWorkoutCount: golfWorkoutCount,
            gymnasticsWorkoutCount: gymnasticsWorkoutCount,
            iceHockeyWorkoutCount: iceHockeyWorkoutCount,
            lacrosseWorkoutCount: lacrosseWorkoutCount,
            mmaWorkoutCount: mmaWorkoutCount,
            wrestlingWorkoutCount: wrestlingWorkoutCount,
            rowingWorkoutCount: rowingWorkoutCount,
            runningWorkoutCount: runningWorkoutCount,
            swimmingWorkoutCount: swimmingWorkoutCount,
            tableTennisWorkoutCount: tableTennisWorkoutCount,
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
            "americanFootballWorkoutCount": score.americanFootballWorkoutCount,
            "badmintonWorkoutCount": score.badmintonWorkoutCount,
            "baseballWorkoutCount": score.baseballWorkoutCount,
            "rugbyWorkoutCount": score.rugbyWorkoutCount,
            "boxingWorkoutCount": score.boxingWorkoutCount,
            "cyclingWorkoutCount": score.cyclingWorkoutCount,
            "golfWorkoutCount": score.golfWorkoutCount,
            "gymnasticsWorkoutCount": score.gymnasticsWorkoutCount,
            "iceHockeyWorkoutCount": score.iceHockeyWorkoutCount,
            "lacrosseWorkoutCount": score.lacrosseWorkoutCount,
            "mmaWorkoutCount": score.mmaWorkoutCount,
            "wrestlingWorkoutCount": score.wrestlingWorkoutCount,
            "rowingWorkoutCount": score.rowingWorkoutCount,
            "runningWorkoutCount": score.runningWorkoutCount,
            "swimmingWorkoutCount": score.swimmingWorkoutCount,
            "tableTennisWorkoutCount": score.tableTennisWorkoutCount,
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
