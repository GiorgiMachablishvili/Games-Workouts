

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



//
//class CustomWorkoutsView: UIView {
//    static func createCustomView(
//        imageName: String,
//        titleText: String,
//        pointText: String,
//        titleFont: UIFont = UIFont.goldmanRegular(size: 14),
//        pointFont: UIFont = UIFont.goldmanRegular(size: 14),
//        textColor: UIColor = .whiteColor,
//        contentMode: UIView.ContentMode = .scaleAspectFit
//    ) -> UIView {
//        let containerView = UIView(frame: .zero)
//
//        let imageView = UIImageView(frame: .zero)
//        imageView.image = UIImage(named: imageName)
//        imageView.contentMode = contentMode
//        containerView.addSubview(imageView)
//
//        let titleLabel = UILabel(frame: .zero)
//        titleLabel.text = titleText
//        titleLabel.textColor = textColor
//        titleLabel.font = titleFont
//        titleLabel.textAlignment = .left
//        containerView.addSubview(titleLabel)
//
//        let pointLabel = UILabel(frame: .zero)
//        pointLabel.text = pointText
//        pointLabel.textColor = textColor
//        pointLabel.font = pointFont
//        pointLabel.textAlignment = .right
//        pointLabel.tag = 1001
//        containerView.addSubview(pointLabel)
//
//        imageView.snp.remakeConstraints { make in
//            make.centerY.equalTo(containerView.snp.centerY)
//            make.leading.equalTo(containerView.snp.leading).offset(1 * Constraint.xCoeff)
//            make.height.width.equalTo(16 * Constraint.yCoeff)
//        }
//
//        titleLabel.snp.remakeConstraints { make in
//            make.centerY.equalTo(imageView.snp.centerY)
//            make.leading.equalTo(imageView.snp.trailing).offset(4 * Constraint.xCoeff)
//            make.width.equalTo(100 * Constraint.xCoeff)
//            make.height.equalTo(17 * Constraint.yCoeff)
//        }
//
//        pointLabel.snp.remakeConstraints { make in
//            make.centerY.equalTo(imageView.snp.centerY)
//            make.trailing.equalTo(containerView.snp.trailing).offset(-1 * Constraint.xCoeff)
//            make.height.equalTo(17 * Constraint.yCoeff)
//        }
//
//        return containerView
//    }
//}
