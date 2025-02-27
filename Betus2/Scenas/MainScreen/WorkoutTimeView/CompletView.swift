

import UIKit
import SnapKit

class CompletView: UIView {

    private lazy var completTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Complet"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.goldmanBold(size: 32)
        return view
    }()

    private lazy var mainImageViewFram: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "appleLogoFrame")
        view.contentMode = .scaleAspectFit
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

    private lazy var completImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "completImage")
        view.contentMode = .scaleAspectFit
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
        addSubview(mainImageViewFram)
        mainImageViewFram.addSubview(timerBackground)
        timerBackground.addSubview(timerBackgroundView)
        timerBackgroundView.addSubview(completImage)
        addSubview(completTitle)
    }


    private func setupConstraints() {
        mainImageViewFram.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(260 * Constraint.xCoeff)
        }

        timerBackground.snp.remakeConstraints { make in
            make.center.equalTo(mainImageViewFram.snp.center)
            make.width.height.equalTo(160 * Constraint.xCoeff)
        }

        timerBackgroundView.snp.remakeConstraints { make in
            make.center.equalTo(timerBackground.snp.center)
            make.width.height.equalTo(140 * Constraint.xCoeff)
        }

        completImage.snp.remakeConstraints { make in
            make.center.equalTo(timerBackgroundView.snp.center)
            make.width.height.equalTo(40 * Constraint.xCoeff)
        }

        completTitle.snp.remakeConstraints { make in
            make.top.equalTo(mainImageViewFram.snp.top)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(32 * Constraint.yCoeff)
        }
    }
}
