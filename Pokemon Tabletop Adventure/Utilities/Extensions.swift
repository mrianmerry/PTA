//
//  Extensions.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 09/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import UIKit

public extension Int {
    public func written(digits: Int = 3) -> String {
        let writtenWithDigits = String(format: "%0\(digits)d", self)
        return writtenWithDigits
    }
}

public extension String {
    public var html: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        let htmlOptions: [NSAttributedString.DocumentReadingOptionKey: Any] =
            [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        return try? NSAttributedString(data: data, options: htmlOptions, documentAttributes: nil)
    }
    
    public var htmlBasic: String {
        return html.value
    }
}

public extension UIView {
    var layoutGuide: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide
        } else {
            return self.layoutMarginsGuide
        }

    }
}

public extension Optional {
    public var exists: Bool {
        return self != nil
    }
}

public extension Optional where Wrapped == String {
    public var orEmpty: String { return self ?? "" }
}

public extension Optional where Wrapped == NSAttributedString {
    public var value: String {
        return self?.string ?? ""
    }
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
