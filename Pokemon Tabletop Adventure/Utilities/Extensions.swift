//
//  Extensions.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 09/07/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

import UIKit

public extension Int {
    func numeral(withDigits digits: Int = 3) -> String {
        let numeral = String(format: "%0\(digits)d", self)
        return numeral
    }
}

public extension String {
    var html: NSAttributedString? {

        let data = Data(utf8)
        let htmlOptions: [NSAttributedString.DocumentReadingOptionKey: Any] =
            [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        return try? NSAttributedString(data: data, options: htmlOptions, documentAttributes: nil)
    }
    
    var htmlBasic: String { return html.value }
}

public extension Optional {
    var exists: Bool { return self != nil }
    var isNone: Bool { return self == nil }
}

public extension Optional where Wrapped == String {
    var orEmpty: String { return self ?? "" }
}

public extension Optional where Wrapped == Int {
    var orZero: Int { return self ?? 0 }
}

public extension Optional where Wrapped == Double {
    var orZero: Double { return self ?? 0 }
}

public extension Optional where Wrapped == Float {
    var orZero: Float { return self ?? 0 }
}

public extension Optional where Wrapped == Bool {
    var orFalse: Bool { return self ?? false }
}

public extension Optional where Wrapped == NSAttributedString {
    var value: String { return self?.string ?? "" }
}

public extension Array where Element: Equatable {
    func random(avoiding element: Element? = nil) -> Element {
        guard count > 1,
            let element = element,
            let index = firstIndex(of: element) else { return trueRandom }

        var randomIndex = index
        while randomIndex == index {
            randomIndex = Int.random(in: 0..<count)
        }

        return self[randomIndex]
    }

    var trueRandom: Element {
        let randomIndex = Int.random(in: 0..<count)
        return self[randomIndex]
    }
}

public extension NSAttributedString {
    func copy(with newColor: UIColor) -> NSAttributedString {
        var stringRange =  NSRange(location: 0, length: string.count)
        var attributes = self.attributes(at: 0, effectiveRange: &stringRange)
        attributes[.foregroundColor] = newColor

        let mutable = NSMutableAttributedString(attributedString: self)
        mutable.setAttributes(attributes, range: stringRange)
        return mutable
    }
}

public extension NSParagraphStyle {
    static var centered: NSParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        return style
    }
}

public extension UIApplication {
    static var buildVersion: String {
        return (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String).orEmpty
    }

    static var appVersion: String {
        return (Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String).orEmpty
    }
}

public extension UIColor {
    static var bodyHex: String = "#404040"
    static var logoHex: String = "#eb463c"
    static var body: UIColor { return UIColor(hex: bodyHex) }
    static var logo: UIColor { return UIColor(hex: logoHex) }

    var inverted: UIColor { return inverse(includingAlpha: false) }

    func inverse(includingAlpha: Bool = true) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: 1 - red, green: 1 - green, blue: 1 - blue, alpha: includingAlpha ? 1 - alpha : alpha)
    }

    convenience init(hex hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let red, green, blue, alpha: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (red, green, blue, alpha) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17, 255)
        case 6: // RGB (24-bit)
            (red, green, blue, alpha) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
        case 8: // RGBA (32-bit)
            (red, green, blue, alpha) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (red, green, blue, alpha) = (0, 0, 0, 255)
        }
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
    }
}

public extension UILabel {
    func updateAttributedText(_ newText: String?) {
        if let text = newText, text.first.exists {
            let attributedString = NSAttributedString(string: text, attributes: attributes)
            attributedText = attributedString
        } else {
            attributedText = nil
        }
    }

    /// Returns the attributes of the first character for any attributedText set in the label.
    var attributes: [NSAttributedString.Key: Any] {
        guard let text = attributedText, text.string.first.exists else { return [:] }
        var textRange =  NSRange(location: 0, length: text.string.count)
        let attributes = text.attributes(at: 0, effectiveRange: &textRange)
        return attributes
    }
}

public extension UINavigationController {
    /// Instructs the navigation controller to add a view controller to its stack without animation, thus preventing built-in animations,
    /// and applies a fade layer transition using the Core Animation Transition API for the supplied duration.
    /// - Parameters:
    ///   - viewController: The view controller to add to the navigation controller's view controller stack.
    ///   - duration: The time interval the animation should stretch over. The default value is `0.3`.
    ///   - replaceOldViewControllers: A flag that instructs the navigation controller to replace the pre-existing view controller stack
    ///   with the supplied view controller. The default value is `false`.
    func crossDissolveViewController(_ viewController: UIViewController,
                                     duration: TimeInterval = 0.3,
                                     replaceOldViewControllers shouldReplace: Bool = false) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        navigationController?.view.layer.add(transition, forKey: nil)
        
        if shouldReplace {
            setViewControllers([viewController], animated: false)
        } else {
            pushViewController(viewController, animated: false)

        }
    }
}

public extension UIProgressView {
    func loop() {
        (progressTintColor, trackTintColor) = (trackTintColor, progressTintColor)
        setProgress(0, animated: false)
    }
}
