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

    let nameplate: UILabel
    let attribution: UITextView

    override var tintColor: UIColor! {
        didSet {
            super.tintColor = tintColor
            nameplate.attributedText = nameplate.attributedText?.copy(with: tintColor)
        }
    }

    init(author: String, credits: String, reuseIdentifier: String?) {
        nameplate = UILabel(frame: .zero)
        attribution = UITextView(frame: .zero)
//        attribution.attributedText = credits.html
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        setupViews()
        set(title: author, message: credits)
    }
    
    func set(title: String, message: String) {
        guard let tint = tintColor else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        let font = UIFont.systemFont(ofSize: 13)
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: tint, .paragraphStyle: paragraphStyle]
        nameplate.attributedText = NSAttributedString(string: title, attributes: attributes)
        
        attribution.attributedText = message.html
    }
}

private extension CreditAttributionTableViewCell {
    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        setupNameplate()
        setupAttribution()
        textLabel?.removeFromSuperview()
        detailTextLabel?.removeFromSuperview()
    }

    func setupNameplate() {
        contentView.addSubview(nameplate)
        nameplate.translatesAutoresizingMaskIntoConstraints = false
        let layoutGuide = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            nameplate.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: 20),
            nameplate.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, multiplier: 0.22),
            nameplate.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 14)]
        )
    }

    func setupAttribution() {
        contentView.addSubview(attribution)
        attribution.translatesAutoresizingMaskIntoConstraints = false
        attribution.isScrollEnabled = false
        attribution.isEditable = false
        let layoutGuide = contentView.safeAreaLayoutGuide
        let nameGuide = nameplate.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            attribution.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -20),
            attribution.leftAnchor.constraint(equalTo: nameGuide.rightAnchor, constant: 3),
            attribution.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 6),
            attribution.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -6),
            attribution.heightAnchor.constraint(greaterThanOrEqualTo: nameGuide.heightAnchor, multiplier: 1)]
        )
    }
}
