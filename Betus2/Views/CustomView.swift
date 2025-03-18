

import UIKit
import SnapKit

class CustomWorkoutsView: UIView {
    private let pointLabel = UILabel()
    private let titleLabel = UILabel()
    private let imageView = UIImageView()

    static func createCustomView(
        imageName: String,
        titleText: String,
        pointText: String,
        titleFont: UIFont = UIFont.goldmanRegular(size: 14),
        pointFont: UIFont = UIFont.goldmanRegular(size: 14),
        textColor: UIColor = .whiteColor,
        contentMode: UIView.ContentMode = .scaleAspectFit
    ) -> CustomWorkoutsView {
        let view = CustomWorkoutsView()

        view.imageView.image = UIImage(named: imageName)
        view.imageView.contentMode = contentMode
        view.addSubview(view.imageView)

        view.titleLabel.text = titleText
        view.titleLabel.textColor = textColor
        view.titleLabel.font = titleFont
        view.titleLabel.textAlignment = .left
        view.addSubview(view.titleLabel)

        view.pointLabel.text = pointText
        view.pointLabel.textColor = textColor
        view.pointLabel.font = pointFont
        view.pointLabel.textAlignment = .right
        view.pointLabel.tag = 1001 // Tag for easy identification
        view.addSubview(view.pointLabel)

        view.setupConstraints()
        return view
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.height.width.equalTo(16)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.width.equalTo(100)
        }

        pointLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
        }
    }

    // Method to update the point text dynamically
    func updatePointText(_ text: String) {
        pointLabel.text = text
    }
}
