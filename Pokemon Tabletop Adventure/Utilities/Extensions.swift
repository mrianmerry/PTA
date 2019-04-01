//
//  Extensions.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 09/07/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

import UIKit

public extension Int {
    public func numeral(withDigits digits: Int = 3) -> String {
        let numeral = String(format: "%0\(digits)d", self)
        return numeral
    }
}

public extension String {
    public var html: NSAttributedString? {

        let data = Data(utf8)
        let htmlOptions: [NSAttributedString.DocumentReadingOptionKey: Any] =
            [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        return try? NSAttributedString(data: data, options: htmlOptions, documentAttributes: nil)
    }
    
    public var htmlBasic: String { return html.value }
}

public extension Optional {
    var exists: Bool { return self != nil }
    var isNone: Bool { return self == nil }
}

public extension Optional where Wrapped == String {
    public var orEmpty: String { return self ?? "" }
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
    public var value: String { return self?.string ?? "" }
}

public extension Array where Element: Equatable {
    public func random(avoiding element: Element? = nil) -> Element {
        guard let element = element,
            let index = index(of: element) else { return trueRandom }

        var randomIndex = index
        while randomIndex == index {
            randomIndex = Int(arc4random_uniform(UInt32(count)))
        }

        return self[randomIndex]
    }

    public var trueRandom: Element {
        let randomIndex = Int(arc4random_uniform(UInt32(count)))
        return self[randomIndex]
    }
}

public extension NSParagraphStyle {
    static var centered: NSParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        return style
    }
}

public extension UIColor {
    static var appLogo: UIColor { return UIColor(hex: "#eb463c") }

    var inverted: UIColor { return inverse(includingAlpha: false) }

    func inverse(includingAlpha: Bool = true) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: 1 - red, green: 1 - green, blue: 1 - blue, alpha: includingAlpha ? 1 - alpha : alpha)
    }

    convenience init(hex hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let red, green, blue, alpha: UInt32
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
        let attributes = text.attributes(at: 0, effectiveRange: nil)
        return attributes
    }
}

public extension UIProgressView {
    func loop() {
        (progressTintColor, trackTintColor) = (trackTintColor, progressTintColor)
        setProgress(0, animated: false)
    }
}
