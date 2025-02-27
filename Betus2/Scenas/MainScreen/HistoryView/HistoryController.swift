

import UIKit
import SnapKit
import Alamofire

class HistoryController: UIViewController {
    private var workoutHistory: [WorkoutScore] = []

    private lazy var backButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "backArrow"), for: .normal)
        view.addTarget(self, action: #selector(pressBackButton), for: .touchUpInside)
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { [weak self] index, _ -> NSCollectionLayoutSection? in
            guard let self else {
                return nil
            }
            return self.historyLayout()
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 8
        layout.configuration = config

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(HistoryCell.self, forCellWithReuseIdentifier: "HistoryCell")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()

        fetchWorkoutCurrentUserInfo()
    }

    private func setup() {
        view.addSubview(backButton)
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        backButton.snp.remakeConstraints { make in
            make.top.equalTo(view.snp.top).offset(44 * Constraint.yCoeff)
            make.leading.equalTo(view.snp.leading).offset(16 * Constraint.xCoeff)
            make.height.width.equalTo(32 * Constraint.yCoeff)
        }

        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
    }

    private func historyLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(51 * Constraint.yCoeff)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: itemSize,
            subitem: item,
            count: 1
        )
        let section = NSCollectionLayoutSection(group: verticalGroup)
        //TODO: instead of 40 should be 8 because should be space between sections
        section.interGroupSpacing = 40
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 8,
            trailing: 0
        )
        return section
    }

    private func fetchWorkoutCurrentUserInfo() {
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? String else {
            return
        }
        let url = String.getWorkoutCountsAndDate(userId: userId)
        NetworkManager.shared.get(url: url, parameters: nil, headers: nil) { (result: Result<[WorkoutScore]>) in
            switch result {
            case .success(let workouts):
                self.workoutHistory = workouts
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    @objc func pressBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension HistoryController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workoutHistory.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else { return UICollectionViewCell()
        }
        let workoutData = workoutHistory[indexPath.item]
        cell.configure(with: workoutData)
        return cell
    }
}
