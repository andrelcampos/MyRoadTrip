//
//  LinkTableViewCell.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 11/06/24.
//

import Foundation
import UIKit

class LinkTableViewCell: UITableViewCell {

    let linkLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.isUserInteractionEnabled = true
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(linkLabel)
        linkLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            linkLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            linkLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            linkLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            linkLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        linkLabel.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        guard let text = linkLabel.text, let url = URL(string: text) else { return }
        UIApplication.shared.open(url)
    }
}
