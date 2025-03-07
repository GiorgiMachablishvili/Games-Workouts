

import UIKit
import SnapKit

class SportImagesCell: UICollectionViewCell {

    lazy var backgroundBackView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.makeRoundCorners(80)
        return view
    }()

    lazy var imageBackgroundColor: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.makeRoundCorners(70)
        return view
    }()

    lazy var sportImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        return view
    }()

    lazy var lockedImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        view.image = UIImage(named: "locked")
        view.isHidden = true
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
        addSubview(backgroundBackView)
        addSubview(imageBackgroundColor)
        addSubview(sportImage)
        addSubview(lockedImage)
    }

    private func setupConstraints() {
        backgroundBackView.snp.remakeConstraints { make in
            make.center.equalTo(snp.center)
            make.height.width.equalTo(160 * Constraint.yCoeff)
        }

        imageBackgroundColor.snp.remakeConstraints { make in
            make.center.equalTo(backgroundBackView.snp.center)
            make.height.width.equalTo(140 * Constraint.yCoeff)
        }

        sportImage.snp.remakeConstraints { make in
            make.center.equalTo(imageBackgroundColor.snp.center)
            make.height.width.equalTo(60 * Constraint.yCoeff)
        }

        lockedImage.snp.remakeConstraints { make in
            make.center.equalTo(imageBackgroundColor.snp.center)
            make.height.width.equalTo(161 * Constraint.yCoeff)
        }
    }

    func configure(with imageName: String/*, isLocked: Bool*/) {
        sportImage.image = UIImage(named: imageName)
//        lockedImage.isHidden = !isLocked
    }
}
