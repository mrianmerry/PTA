//
//  CreditAttributionTableViewCell.swift
//  P:TA Companion
//
//  Created by Ian Merryweather on 01/04/2019.
//  Copyright © 2019 Undersea Love. All rights reserved.
//

import UIKit

class CreditAttributionTableViewCell: UITableViewCell {
    required init?(coder aDecoder: NSCoder) { return nil }

    let attribution: UITextView

    override var tintColor: UIColor! {
        didSet {
            super.tintColor = tintColor
            textLabel?.attributedText = textLabel?.attributedText?.copy(with: tintColor)
        }
    }

    init(credits: String, reuseIdentifier: String?) {
        attribution = UITextView(frame: .zero)
        attribution.attributedText = credits.html
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    func setupViews() {
        setupTitle()
        setupAttribution()
        detailTextLabel?.removeFromSuperview()
    }

    func setupTitle() {
        guard let title = textLabel else { fatalError("How the fuck did this happen?") }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        let font = UIFont.systemFont(ofSize: 13)

        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: tintColor, .paragraphStyle: paragraphStyle]
        title.attributedText = NSAttributedString(string: " ", attributes: attributes)

        title.translatesAutoresizingMaskIntoConstraints = false
        let layoutGuide = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
        [title.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: 20),
         title.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, multiplier: 0.22),
         title.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 14)]
        )
    }

    func setupAttribution() {
        guard let titleGuide = textLabel?.safeAreaLayoutGuide else { fatalError("How the fuck did this happen?") }

        contentView.addSubview(attribution)
        attribution.translatesAutoresizingMaskIntoConstraints = false
        attribution.isScrollEnabled = false
        attribution.isEditable = false
        let layoutGuide = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            [attribution.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -20),
             attribution.leftAnchor.constraint(equalTo: titleGuide.rightAnchor, constant: 3),
             attribution.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 6),
             attribution.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -6),
             attribution.heightAnchor.constraint(greaterThanOrEqualTo: titleGuide.heightAnchor, multiplier: 1)]
        )

    }
}
