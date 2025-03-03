

import UIKit
import SnapKit

class TopView: UIView {

    var onProfileButtonTap: (() -> Void)?
    var onHistoryButtonTap: (() -> Void)?

    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.attributedText = makeTopViewAttributedString(for: "Tennis")
        view.textAlignment = .left
        return view
    }()

    private lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.backgroundColor = .clear
        return view
    }()

    lazy var numberOfWorkoutDays: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "0"
        view.font = UIFont.goldmanBold(size: 32)
        view.textColor = .whiteColor
        return view
    }()

    lazy var historyButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "history"), for: .normal)
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(clickHistoryButton), for: .touchUpInside)
        return view
    }()

    private lazy var profileButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "profile"), for: .normal)
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(clickProfileButton), for: .touchUpInside)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        setupConstraints()

        fetchWorkoutScore()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(titleLabel)
        addSubview(calendarView)
        addSubview(numberOfWorkoutDays)
        addSubview(historyButton)
        addSubview(profileButton)
    }

    private func setupConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(16 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(16 * Constraint.xCoeff)
        }

        calendarView.snp.remakeConstraints { make in
            make.bottom.equalTo(snp.bottom).offset(-16 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(40 * Constraint.yCoeff)
        }

        numberOfWorkoutDays.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(16 * Constraint.xCoeff)
            make.height.equalTo(25 * Constraint.yCoeff)
            make.width.equalTo(25 * Constraint.xCoeff)
        }

        profileButton.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(16 * Constraint.yCoeff)
            make.trailing.equalTo(snp.trailing).offset(-16 * Constraint.xCoeff)
            make.height.width.equalTo(32 * Constraint.yCoeff)
        }

        historyButton.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(16 * Constraint.yCoeff)
            make.trailing.equalTo(profileButton.snp.leading).offset(-8 * Constraint.xCoeff)
            make.height.width.equalTo(32 * Constraint.yCoeff)
        }
    }

    func makeTopViewAttributedString(for sport: String) -> NSAttributedString {
        let text = "Consecutive days of \(sport.lowercased())\ntraining"
        let attributedString = NSMutableAttributedString(string: text)

        let prefixRange = (text as NSString).range(of: "Consecutive days of")
        attributedString.addAttributes([
            .foregroundColor: UIColor.white,
            .font: UIFont.goldmanRegular(size: 14)
        ], range: prefixRange)

        let sportRange = (text as NSString).range(of: sport.lowercased())
        attributedString.addAttributes([
            .foregroundColor: UIColor.redColor,
            .font: UIFont.goldmanBold(size: 14)
        ], range: sportRange)

        let trainingRange = (text as NSString).range(of: "training")
        attributedString.addAttributes([
            .foregroundColor: UIColor.white,
            .font: UIFont.goldmanRegular(size: 14)
        ], range: trainingRange)

        return attributedString
    }

    private func fetchWorkoutScore() {
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? String else {
            return
        }

        let url = String.getWorkoutDaysInARow(userId: userId)
        NetworkManager.shared.get(url: url, parameters: nil, headers: nil) { (result: Result<WorkoutDayCountInRow>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.updateNumberOfWorkoutDays(streakCount: response.streak_count)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func updateNumberOfWorkoutDays(streakCount: Int) {
        numberOfWorkoutDays.text = "\(streakCount)"
    }

    //TOD: make history view
    @objc private func clickHistoryButton() {
        onHistoryButtonTap?()
    }

    @objc private func clickProfileButton() {
        onProfileButtonTap?()
    }
}
