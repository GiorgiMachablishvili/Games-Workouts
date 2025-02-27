

import UIKit

extension UIFont {
    //MARK: font extension
    static func goldmanRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Goldman-Regular", size: size) ?? .systemFont(ofSize: size)
    }

    static func goldmanBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Goldman-Bold", size: size) ?? .systemFont(ofSize: size)
    }
}
