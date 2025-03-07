

import UIKit
import SnapKit

//@available(iOS 15.0, *)
class MainDashboardScene: UIViewController {
    //    private var isSubscribed: Bool = false {
    //        didSet {
    //            collectionView.reloadData()
    //        }
    //    }

    private let allSports = ["", "tennis", "basketball", "volleyball", "soccer", ""]

    //    private var images: [String] {
    //        return isSubscribed ? allSports : ["", "soccer", "tennis", "basketball", "volleyball", ""]
    //    }

    private var images = ["", "soccer", "tennis", "basketball", "volleyball", ""]


    private lazy var warningView: WarningView = {
        let view = WarningView()
        view.makeRoundCorners(32)
        view.onAcceptButtonTap = { [weak self] in
            self?.hideWarningView()
        }
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80 * Constraint.xCoeff, height: 80 * Constraint.yCoeff)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32 * Constraint.xCoeff, bottom: 0, right: 32 * Constraint.xCoeff)
        layout.minimumLineSpacing = 35  * Constraint.xCoeff
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(SportImagesCell.self, forCellWithReuseIdentifier: "SportImagesCell")
        return view
    }()

    private lazy var topView: TopView = {
        let view = TopView()
        view.backgroundColor = UIColor.topBottomViewColorGray
        view.makeRoundCorners(32)
        view.onProfileButtonTap = { [weak self] in
            self?.navigateToProfile()
        }
        view.onHistoryButtonTap = { [weak self] in
            self?.navigationToHistory()
        }
        return view
    }()

    private lazy var sportLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "TENNIS"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.goldmanBold(size: 32)
        return view
    }()

    private lazy var sportImageBackView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "appleLogoFrame")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var bottomView: BottomView = {
        let view = BottomView()
        view.backgroundColor = UIColor.topBottomViewColorGray
        view.makeRoundCorners(32)
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBlack

        self.navigationController?.setNavigationBarHidden(true, animated: false)

        setup()
        setupConstraints()
        hiddenOrUnhidden()
        //        fetchSubscriptionStatus()
        //        updateBackground()

        DispatchQueue.main.async {
            let tennisIndex = 1
            let indexPath = IndexPath(item: tennisIndex, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            self.updateViewForSport(at: indexPath)
        }
    }

    private func setup() {
        view.addSubview(topView)
        view.addSubview(sportLabel)
        view.addSubview(sportImageBackView)
        view.addSubview(collectionView)
        view.addSubview(bottomView)
        view.addSubview(warningView)
    }

    private func setupConstraints() {
        warningView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        topView.snp.remakeConstraints { make in
            make.top.equalTo(view.snp.top).offset(44 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(156 * Constraint.yCoeff)
        }

        sportLabel.snp.remakeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(82 * Constraint.yCoeff)
            make.centerX.equalToSuperview()
            make.height.equalTo(38 * Constraint.yCoeff)
        }

        sportImageBackView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(260 * Constraint.yCoeff)
        }

        collectionView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(160 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(15 * Constraint.xCoeff)
        }

        bottomView.snp.remakeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-24 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(159 * Constraint.yCoeff)
        }
    }

    //    private func fetchSubscriptionStatus() {
    //        Task {
    //            let storeVM = StoreVM()
    //            await storeVM.updateCustomerProductStatus()
    //            DispatchQueue.main.async {
    //                self.isSubscribed = storeVM.purchasedSubscriptions.isEmpty
    //                self.collectionView.reloadData()
    //            }
    //        }
    //    }

    private func updateViewForSport(at indexPath: IndexPath) {
        guard !allSports[indexPath.item].isEmpty else { return }

        let sportName = allSports[indexPath.item].lowercased()

        // Ensure only "soccer" is displayed when not subscribed
        //        if !isSubscribed && sportName != "soccer" {
        //            sportLabel.text = "SOCCER"
        //        } else {
        //            sportLabel.text = sportName.uppercased()
        //        }

        topView.titleLabel.attributedText = topView.makeTopViewAttributedString(for: sportLabel.text ?? "")
        updateBottomView(for: sportName)
    }

    private func hideWarningView() {
        warningView.isHidden = true
    }

    private func navigateToProfile() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }

    private func navigationToHistory() {
        let historyVC = HistoryController()
        navigationController?.pushViewController(historyVC, animated: true)
    }

    //TODO: make button hidden if user is as guest update all
    private func hiddenOrUnhidden() {
        let isGuestUser = UserDefaults.standard.bool(forKey: "isGuestUser")
        topView.historyButton.isHidden = isGuestUser
        topView.numberOfWorkoutDays.isHidden = isGuestUser
        //        warningView.isHidden = isGuestUser
        //TODO: un comment
        //        bottomView.startButton.isHidden = isGuestUser
    }

    private func updateGoToProButton() {
        bottomView.startButton.setTitle("Locked", for: .normal)
        bottomView.startButton.setTitleColor(UIColor.whiteColor, for: .normal)
        bottomView.startButton.titleLabel?.font = UIFont.goldmanRegular(size: 14)
        bottomView.startButton.backgroundColor = UIColor.redColor
        bottomView.startButton.makeRoundCorners(16)
        let image = UIImage(named: "crown")?.withRenderingMode(.alwaysOriginal)
        let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 19 * Constraint.xCoeff, height: 18 * Constraint.yCoeff)).image { _ in
            image?.draw(in: CGRect(origin: .zero, size: CGSize(width: 19 * Constraint.xCoeff, height: 18 * Constraint.yCoeff)))
        }
        bottomView.startButton.setImage(resizedImage, for: .normal)
        bottomView.startButton.imageView?.contentMode = .scaleAspectFit
        bottomView.startButton.semanticContentAttribute = .forceRightToLeft
        bottomView.startButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8 * Constraint.xCoeff)
        bottomView.startButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8 * Constraint.xCoeff, bottom: 0, right: 0)
        bottomView.startButton.contentHorizontalAlignment = .center

        bottomView.startButton.snp.updateConstraints { make in
            make.width.equalTo(123 * Constraint.xCoeff)
        }
        
    }

    private func updateStartButton() {
        bottomView.startButton.setTitle("Start ", for: .normal)
        bottomView.startButton.setTitleColor(UIColor.whiteColor, for: .normal)
        bottomView.startButton.titleLabel?.font = UIFont.goldmanRegular(size: 14)
        bottomView.startButton.backgroundColor = UIColor.redColor
        bottomView.startButton.makeRoundCorners(16)
        let image = UIImage(named: "play")?.withRenderingMode(.alwaysOriginal)
        let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 19 * Constraint.xCoeff, height: 18 * Constraint.yCoeff)).image { _ in
            image?.draw(in: CGRect(origin: .zero, size: CGSize(width: 19 * Constraint.xCoeff, height: 18 * Constraint.yCoeff)))
        }
        bottomView.startButton.setImage(resizedImage, for: .normal)
        bottomView.startButton.imageView?.contentMode = .scaleAspectFit
        bottomView.startButton.semanticContentAttribute = .forceRightToLeft
        bottomView.startButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8 * Constraint.xCoeff)
        bottomView.startButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8 * Constraint.xCoeff, bottom: 0, right: 0)
        bottomView.startButton.contentHorizontalAlignment = .center

        bottomView.startButton.snp.updateConstraints { make in
            make.width.equalTo(87 * Constraint.xCoeff)
        }
    }

    private func updateBottomView(for sport: String) {
        let bottomViewInfo: ViewInfo

        switch sport.lowercased() {
        case "tennis":
            bottomViewInfo = ViewInfo(
                title: "Daily tennis workout",
                description: """
                Daily tennis training: improve your coordination, form and skill on the court. Increase your reaction, strength and flexibility with every training session.
                """,
                timer: "25"
            )
        case "basketball":
            bottomViewInfo = ViewInfo(
                title: "Daily basketball workout",
                description: """
                Daily basketball training: improve your coordination, endurance and skill in the game. Develop reaction, speed and flexibility on the court with every exercise.
                """,
                timer: "30"
            )
        case "volleyball":
            bottomViewInfo = ViewInfo(
                title: "Daily volleyball workout",
                description: """
                Daily volleyball training: improve your technique, endurance and sense of play. Improve your reaction, speed and flexibility on the court with every exercise.
                """,
                timer: "27"
            )
        case "soccer":
            bottomViewInfo = ViewInfo(
                title: "Daily soccer workout",
                description: "Daily soccer training: develop coordination, endurance and technique. Improve your reaction, speed and flexibility on the pitch with every exercise",
                timer: "30"
            )

        default:
            bottomViewInfo = ViewInfo(title: "", description: "", timer: "0")
        }

        bottomView.configure(data: bottomViewInfo)
    }
}

//@available(iOS 15.0, *)
extension MainDashboardScene: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allSports.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportImagesCell", for: indexPath) as? SportImagesCell else {
            return UICollectionViewCell()
        }
        let sportName = allSports[indexPath.item]
        //        let isLocked = isSubscribed && (sportName != "soccer" && !sportName.isEmpty)
        cell.configure(with: sportName)
        return cell
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Get the target content offset and calculate the target index
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = layout.itemSize.width + layout.minimumLineSpacing
        let targetX = targetContentOffset.pointee.x
        let targetIndex = round(targetX / itemWidth)

        let clampedIndex = max(0, min(CGFloat(allSports.count - 1), targetIndex))
        targetContentOffset.pointee = CGPoint(x: clampedIndex * itemWidth, y: 0)

        let indexPath = IndexPath(item: Int(clampedIndex), section: 0)
        let sportName = allSports[indexPath.item]
        sportLabel.text = sportName.uppercased()
        updateBottomView(for: sportName)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerX = collectionView.bounds.width / 2 + collectionView.contentOffset.x
        var closestIndexPath: IndexPath?
        var minimumDistance: CGFloat = .greatestFiniteMagnitude

        for cell in collectionView.visibleCells {
            guard let indexPath = collectionView.indexPath(for: cell),
                  let layoutAttributes = collectionView.layoutAttributesForItem(at: indexPath),
                  let sportCell = cell as? SportImagesCell else { continue }

            let cellCenter = layoutAttributes.center.x
            let distance = abs(centerX - cellCenter)

            if distance < minimumDistance {
                closestIndexPath = indexPath
                minimumDistance = distance
            }

            let maxDistance = collectionView.bounds.width / 2
            let scale = max(1 - (distance / maxDistance), 0.5)
            sportCell.transform = CGAffineTransform(scaleX: scale, y: scale)

            //MARK: Middle image
            if distance < 10 {
                sportCell.backgroundBackView.backgroundColor = UIColor.redColor.withAlphaComponent(0.2)
                sportCell.imageBackgroundColor.backgroundColor = UIColor.redColor
                //                sportCell.imageDarkBackgroundColor.backgroundColor = .clear
                if !allSports[indexPath.item].isEmpty {
                    let sportName = allSports[indexPath.item].uppercased()
                    sportLabel.text = sportName
                    topView.titleLabel.attributedText = topView.makeTopViewAttributedString(for: sportName)
                    updateBottomView(for: allSports[indexPath.item])
                }
            } else {
                sportCell.backgroundBackView.backgroundColor = .clear
                sportCell.imageBackgroundColor.backgroundColor = .clear
            }
        }

        //MARK: hide or unhide locked image
        if let closestIndexPath = closestIndexPath {
            let sportName = allSports[closestIndexPath.item].lowercased()
            sportLabel.text = sportName.uppercased()
            updateBottomView(for: sportName)

            let isUserSignedIn = UserDefaults.standard.string(forKey: "userId")?.isEmpty == false

            if !isUserSignedIn && (sportName == "tennis" || sportName == "basketball" || sportName == "volleyball") {
                if let cell = collectionView.cellForItem(at: closestIndexPath) as? SportImagesCell {
                    cell.lockedImage.isHidden = false
                    cell.backgroundBackView.isHidden = true
                }
                updateGoToProButton()
            } else {
                if let cell = collectionView.cellForItem(at: closestIndexPath) as? SportImagesCell {
                    cell.lockedImage.isHidden = true
                    cell.backgroundBackView.isHidden = false
                }
                updateStartButton()
            }
        }
    }
}

//@available(iOS 15.0, *)
extension MainDashboardScene: BottomViewDelegate {
    @available(iOS 15.0, *)
    func didTapStartButton() {
        if bottomView.startButton.title(for: .normal) == "Start " {
            let workoutTimeView = WorkoutTimeView()
            workoutTimeView.selectedSport = sportLabel.text
            navigationController?.pushViewController(workoutTimeView, animated: false)
        } else {
//            if let currentTopVC = navigationController?.topViewController,
//               currentTopVC is SubscriptionMainViewController {
//                // Prevent duplicate pushes to SubscriptionMainViewController
//                return
//            }
//
//            let subscriptionVC = SubscriptionMainViewController()
//            navigationController?.pushViewController(subscriptionVC, animated: true)
        }
    }
}
