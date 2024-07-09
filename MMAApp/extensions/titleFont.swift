import UIKit

extension UINavigationController {
    func setTitleColor(_ color: UIColor) {
        let textAttributes = [NSAttributedString.Key.foregroundColor: color]
        navigationBar.titleTextAttributes = textAttributes
    }
}
